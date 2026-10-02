# NEFESH OpenEMR 8.4.1 hotpatch - pr13762-icd10-import-v1

- Purpose: backport of upstream PR #13762 (fix(icd10): support April 1 mid-year ICD-10 releases): `icd_import()` inactivates only the ICD-10 code set(s) (dx and/or pcs) that the staged release contains; new `icd_import_file_keys()`.
- Associated issue: https://github.com/openemr/openemr/issues/13661 (opened by NEFESH, closed 2026-09-29)
- Upstream PR: https://github.com/openemr/openemr/pull/13762 (merged 2026-09-29 to master, 8.5.0 line); companion data PR https://github.com/openemr/openemr/pull/14280 (FY 2027 files + rows, merged 2026-09-26)
- OpenEMR baseline: `v8_4_1` / `a43edad9ea6d969fcbcc1df7d8ccc50ad34fd872`; stock `library/standard_tables_capture.inc.php` verified identical on SANDBOX and MAIN (sha256 acfc106e...). Applies cleanly (git apply, LF, +74/-41).
- Status: installed and functionally tested (4/4 `icd_import_file_keys` cases) on SANDBOX and MAIN 2026-10-02. The companion data package (`../icd10-fy2027-data-v1`) stages the FY2027 files; the import itself is an Admin UI step.
- Retirement rule: retire only when the installed official release contains #13762 and the ICD-10 import regression passes.
