# NEFESH OpenEMR 8.4.1 hotpatch - pr13713-14262-delete-v2

- Purpose: Decouple delete refresh from SQL display (#13713) + document view Delete uses document_pid (upstream #14262, merged 2026-10-02 to master)
- Associated issue(s): #13707, #14235
- Upstream PR(s): #13713, #14262
- OpenEMR baseline: `v8_4_1` / `a43edad9ea6d969fcbcc1df7d8ccc50ad34fd872` (docker image `openemr/openemr:8.4.1-2026-10-01`; every stock file below was verified byte-identical to this tag)
- Status: NEW 2026-10-02: supersedes pr13713-delete-refresh-v1; #14262 part retires when a release contains it
- Files (stock hash = tag blob; candidate = payload):
  - `interface/patient_file/deleter.php` base_matches_tag=yes candidate_hash_ok=yes
  - `controllers/C_Document.class.php` base_matches_tag=yes candidate_hash_ok=yes
  - `templates/documents/general_view.html` base_matches_tag=yes candidate_hash_ok=yes
- Install (NAS): wrapper verbs `status|install|uninstall` via the shared helper `../_nefesh-openemr840-file-hotpatch-lib-v1.sh`; env `OPENEMR_CONTAINER`.
  - Wrapper: `nefesh-delete-refresh-hotpatch-v2-openemr840.sh`.
- Retirement rule: upstream merge alone does not retire a running hotpatch; retire only when the official OpenEMR release NEFESH actually installs contains an equivalent fix and regression validation passes.
- Install/replace note: a recreate of the container wipes all container-local hotpatches; reinstall after every recreate.
