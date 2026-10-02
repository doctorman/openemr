# NEFESH OpenEMR 8.4.1 hotpatch - feesheet-payer-null-v1

- Purpose: FeeSheet constructor: guard payer_id against getInsuranceData() returning false (no PHP warning for uninsured patients)
- Associated issue(s): #14340
- Upstream PR(s): none yet
- OpenEMR baseline: `v8_4_1` / `a43edad9ea6d969fcbcc1df7d8ccc50ad34fd872` (docker image `openemr/openemr:8.4.1-2026-10-01`; every stock file below was verified byte-identical to this tag)
- Status: NEW 2026-10-02: issue #14340 filed by NEFESH; no PR yet
- Files (stock hash = tag blob; candidate = payload):
  - `library/FeeSheet.class.php` base_matches_tag=yes candidate_hash_ok=yes
- Install (NAS): wrapper verbs `status|install|uninstall` via the shared helper `../_nefesh-openemr840-file-hotpatch-lib-v1.sh`; env `OPENEMR_CONTAINER`.
  - Wrapper: `nefesh-feesheet-payer-null-hotpatch-v1-openemr840.sh`.
- Retirement rule: upstream merge alone does not retire a running hotpatch; retire only when the official OpenEMR release NEFESH actually installs contains an equivalent fix and regression validation passes.
- Install/replace note: a recreate of the container wipes all container-local hotpatches; reinstall after every recreate.
