#!/bin/sh
set -eu
ACTION=${1:-status}
C=${OPENEMR_CONTAINER:-sandbox-openemr-1}
ROOT=${OPENEMR_ROOT:-/var/www/localhost/htdocs/openemr}
P=${NEFESH_PATCH_ROOT:?NEFESH_PATCH_ROOT_not_set}
M=$P/manifest.psv
PAY=$P/payload
BAK=$P/backups/stock-v8_4_0
die(){ echo "[ERROR] $*" >&2; exit 1; }
hostsha(){ sha256sum "$1" | awk '{print $1}'; }
containersha(){ docker exec "$C" sha256sum "$ROOT/$1" | awk '{print $1}'; }
waithealthy(){ i=0; while [ "$i" -lt 90 ]; do h=$(docker inspect -f '{{if .State.Health}}{{.State.Health.Status}}{{else}}none{{end}}' "$C" 2>/dev/null || true); [ "$h" = healthy ] && return 0; sleep 2; i=$((i+1)); done; die "container did not become healthy"; }
lintfile(){ kind="$1"; path="$2"; case "$kind" in php) docker exec "$C" php -l "$path" >/dev/null;; node) docker exec "$C" node --check "$path" >/dev/null;; none) :;; *) die "unknown lint type $kind";; esac; }
require(){ docker inspect "$C" >/dev/null 2>&1 || die "container $C missing"; [ -f "$M" ] || die "manifest missing"; [ -d "$PAY" ] || die "payload missing"; }
showstatus(){
  require
  while IFS='|' read -r rel base cand lint; do
    case "$rel" in ''|'#'*) continue;; esac
    cur=$(containersha "$rel")
    if [ "$cur" = "$cand" ]; then s=PATCHED; elif [ "$cur" = "$base" ]; then s=STOCK; else s=OTHER; fi
    echo "$s|$rel|$cur"
  done < "$M"
}
installpatch(){
  require
  mkdir -p "$BAK"
  while IFS='|' read -r rel base cand lint; do
    case "$rel" in ''|'#'*) continue;; esac
    [ "$(hostsha "$PAY/$rel")" = "$cand" ] || die "payload hash mismatch: $rel"
    cur=$(containersha "$rel")
    if [ "$cur" = "$cand" ]; then echo "[OK] already patched: $rel"; continue; fi
    [ "$cur" = "$base" ] || die "unexpected live baseline for $rel: $cur"
    b="$BAK/$rel"; mkdir -p "$(dirname "$b")"
    if [ ! -f "$b" ]; then docker cp "$C:$ROOT/$rel" "$b" >/dev/null; fi
    [ "$(hostsha "$b")" = "$base" ] || die "backup hash mismatch: $rel"
    tmp="/tmp/nefesh-hotpatch-$(echo "$rel" | tr '/.' '__')-$$"
    docker cp "$PAY/$rel" "$C:$tmp" >/dev/null
    lintfile "$lint" "$tmp"
    docker exec "$C" rm -f "$tmp"
    echo "[READY] $rel"
  done < "$M"
  while IFS='|' read -r rel base cand lint; do
    case "$rel" in ''|'#'*) continue;; esac
    cur=$(containersha "$rel")
    [ "$cur" = "$cand" ] && continue
    [ "$cur" = "$base" ] || die "baseline changed before commit: $rel"
    docker cp "$PAY/$rel" "$C:$ROOT/$rel" >/dev/null
    docker exec -u 0 "$C" chown apache:apache "$ROOT/$rel"
    docker exec -u 0 "$C" chmod 400 "$ROOT/$rel"
    lintfile "$lint" "$ROOT/$rel"
    [ "$(containersha "$rel")" = "$cand" ] || die "post-install hash mismatch: $rel"
    echo "[INSTALLED] $rel"
  done < "$M"
  docker restart "$C" >/dev/null
  waithealthy
  showstatus
}
restorepatch(){
  require
  while IFS='|' read -r rel base cand lint; do
    case "$rel" in ''|'#'*) continue;; esac
    cur=$(containersha "$rel")
    if [ "$cur" = "$base" ]; then echo "[OK] already stock: $rel"; continue; fi
    [ "$cur" = "$cand" ] || die "refusing restore from unexpected live file: $rel"
    b="$BAK/$rel"; [ -f "$b" ] || die "backup missing: $rel"
    [ "$(hostsha "$b")" = "$base" ] || die "backup hash mismatch: $rel"
  done < "$M"
  while IFS='|' read -r rel base cand lint; do
    case "$rel" in ''|'#'*) continue;; esac
    cur=$(containersha "$rel")
    [ "$cur" = "$base" ] && continue
    b="$BAK/$rel"
    docker cp "$b" "$C:$ROOT/$rel" >/dev/null
    docker exec -u 0 "$C" chown apache:apache "$ROOT/$rel"
    docker exec -u 0 "$C" chmod 400 "$ROOT/$rel"
    lintfile "$lint" "$ROOT/$rel"
    [ "$(containersha "$rel")" = "$base" ] || die "restore hash mismatch: $rel"
    echo "[RESTORED] $rel"
  done < "$M"
  docker restart "$C" >/dev/null
  waithealthy
  showstatus
}
case "$ACTION" in
  install|update) installpatch;;
  status) showstatus;;
  restore|uninstall) restorepatch;;
  *) echo "Usage: $0 {install|update|status|restore|uninstall}" >&2; exit 2;;
esac
