# icd10-fy2027-data-v1 (data package, not managed by the hotpatch lib)

Upstream: PR #14280 (FY 2027 ICD-10-CM + ICD-10-PCS, effective 2026-10-01) and PR #13762 (April 1 2026 rows). Both are in master (8.5.0 line) only; OpenEMR 8.4.1 has `supported_external_dataloads` rows only through 2025-10-01, so FY2027 files are rejected as UNSUPPORTED.

Files here: `supported_dataloads.sql` (idempotent rows, version table untouched), `apply-icd10-data.sh sandbox|main` (table dump, rows, replace staged FY2026 zips with the two FY2027 zips in `contrib/icd10`, verify the `list_staged.php` lookup; does NOT import), `MD5SUMS.txt`, `removed_codes.txt` (21), `added_codes.txt` (238), `changed_codes.txt` (19).

The two official CMS zips are not stored here (public, in upstream master `contrib/icd10/` at commit 0779d64b8fcd112bdccddd83d689b0200f5f0a4c): `2027-code-descriptions-in-tabular-order.zip` md5 d71d4467481e3396991576a02e030213, `zip-file-3-2027-icd-10-pcs-codes-file.zip` md5 ca7dd9e61622a3b9faf766ac6b1cd15d.

Importer behaviour in 8.4.1: inactivates both dx and pcs rows, then loads the staged release; the Code Systems page requires only the files of one release to be staged. Status 2026-10-02: staged on SANDBOX and MAIN, import pending.
