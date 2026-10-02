#!/bin/sh
# NEFESH: stage the FY2027 ICD-10 data on one environment WITHOUT running the OpenEMR import.
# Usage: sh apply-icd10-data.sh sandbox|main   (run on the NAS as root; pkg dir = this script's folder)
# Steps: pre-checks -> table dump (rollback) -> insert supported_external_dataloads rows -> replace staged FY2026 zips
# with the two FY2027 zips in contrib/icd10 -> verify the same lookup list_staged.php does. No import, no version-table change.
set -eu
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
ENV="${1:-}"
D=$(cd "$(dirname "$0")" && pwd)
case "$ENV" in
  sandbox) DB=sandbox-database-1; WEB=sandbox-openemr-1; BR=/volume2/SandboxEMR/backups;;
  main)    DB=emr-database-1;     WEB=emr-openemr-1;     BR=/volume2/emr_upgrade_backups;;
  *) echo "ICD10DATA_FAIL usage sandbox|main"; exit 2;;
esac
TS=$(date +%Y%m%d-%H%M%S)
B=$BR/pre-icd10-fy2027-$TS
CM=2027-code-descriptions-in-tabular-order.zip
PCS=zip-file-3-2027-icd-10-pcs-codes-file.zip
CMMD5=d71d4467481e3396991576a02e030213
PCSMD5=ca7dd9e61622a3b9faf766ac6b1cd15d
STG=/var/www/localhost/htdocs/openemr/contrib/icd10
log(){ echo "$(date +%H:%M:%S) $*"; }
die(){ echo "ICD10DATA_FAIL $*"; exit 1; }
sql(){ docker exec -i $DB sh -c 'mariadb -uroot -p"$MYSQL_ROOT_PASSWORD" openemr' ; }
log START $ENV
[ "$(docker inspect -f '{{.State.Health.Status}}' $WEB)" = healthy ] || die web_not_healthy
[ "$(docker inspect -f '{{.State.Health.Status}}' $DB)" = healthy ] || die db_not_healthy
[ "$(md5sum "$D/$CM" | cut -d' ' -f1)" = "$CMMD5" ] || die cm_zip_md5
[ "$(md5sum "$D/$PCS" | cut -d' ' -f1)" = "$PCSMD5" ] || die pcs_zip_md5
mkdir -p "$B"; chmod 700 "$B"
echo "SELECT 'dx_rows',COUNT(*),SUM(active),MAX(revision) FROM icd10_dx_order_code UNION ALL SELECT 'pcs_rows',COUNT(*),SUM(active),MAX(revision) FROM icd10_pcs_order_code UNION ALL SELECT 'supported_icd10',COUNT(*),0,0 FROM supported_external_dataloads WHERE load_type='ICD10';" | sql > "$B/counts-before.txt" 2>&1 || die counts_before
cat "$B/counts-before.txt"
docker exec $DB sh -c 'mariadb-dump -uroot -p"$MYSQL_ROOT_PASSWORD" --single-transaction openemr icd10_dx_order_code icd10_pcs_order_code supported_external_dataloads standardized_tables_track code_types' | gzip > "$B/icd10-tables.sql.gz" || die dump
gzip -t "$B/icd10-tables.sql.gz" || die dump_gzip
log "DUMP_DONE $B ($(wc -c < $B/icd10-tables.sql.gz) bytes)"
docker exec $WEB ls -la $STG > "$B/staging-before.txt" 2>&1 || die staging_list
mkdir -p "$B/fy2026-zips"
for f in $(docker exec $WEB sh -c "ls $STG | grep -E '\.zip$'"); do docker cp "$WEB:$STG/$f" "$B/fy2026-zips/$f" >/dev/null || die "save_$f"; done
ls -la "$B/fy2026-zips" > "$B/fy2026-saved.txt"
sql < "$D/supported_dataloads.sql" || die insert_rows
log ROWS_INSERTED
for f in $(docker exec $WEB sh -c "ls $STG | grep -E '\.zip$'"); do docker exec $WEB rm -f "$STG/$f" || die "rm_$f"; done
docker cp "$D/$CM" "$WEB:$STG/$CM" >/dev/null || die cp_cm
docker cp "$D/$PCS" "$WEB:$STG/$PCS" >/dev/null || die cp_pcs
docker exec -u 0 $WEB sh -c "chown apache:apache $STG/$CM $STG/$PCS && chmod 400 $STG/$CM $STG/$PCS" || die chown
log STAGED
[ "$(docker exec $WEB md5sum $STG/$CM | cut -d' ' -f1)" = "$CMMD5" ] || die staged_cm_md5
[ "$(docker exec $WEB md5sum $STG/$PCS | cut -d' ' -f1)" = "$PCSMD5" ] || die staged_pcs_md5
docker exec $WEB ls -la $STG
echo "SELECT 'match_cm',COUNT(*) FROM supported_external_dataloads WHERE load_type='ICD10' AND load_filename='$CM' AND load_checksum='$CMMD5' UNION ALL SELECT 'match_pcs',COUNT(*) FROM supported_external_dataloads WHERE load_type='ICD10' AND load_filename='$PCS' AND load_checksum='$PCSMD5' UNION ALL SELECT 'files_for_release_2026-10-01',COUNT(*) FROM supported_external_dataloads WHERE load_type='ICD10' AND load_source='CMS' AND load_release_date='2026-10-01';" | sql | tee "$B/verify.txt"
[ "$(grep -c -E '^(match_cm|match_pcs)	1$' "$B/verify.txt")" = 2 ] || die lookup_mismatch
grep -q '^files_for_release_2026-10-01	2$' "$B/verify.txt" || die release_file_count
echo "SELECT 'dx_rows_after',COUNT(*),SUM(active),MAX(revision) FROM icd10_dx_order_code;" | sql > "$B/counts-after.txt"
echo ICD10DATA_STAGED > "$B/ICD10DATA_STAGED"
log "ICD10DATA_PASS (nothing imported; run Admin > Coding > Code Systems > ICD10 > Install next; rollback: restore tables from $B/icd10-tables.sql.gz and put fy2026-zips back)"
