# NEFESH OpenEMR 8.4.1 hotpatch - session-shell-combined-v2

- Purpose: Idle-timeout warning (#13712) + expired-shell site context (#14009 v2) + background polls must not reset idle timeout (#14308, open upstream PR by another author)
- Associated issue(s): #14008
- Upstream PR(s): #13712, #14009, #14308
- OpenEMR baseline: `v8_4_1` / `a43edad9ea6d969fcbcc1df7d8ccc50ad34fd872` (docker image `openemr/openemr:8.4.1-2026-10-01`; every stock file below was verified byte-identical to this tag)
- Status: NEW 2026-10-02: supersedes session-shell-combined-v1; #14308 part is an UNMERGED upstream PR
- Files (stock hash = tag blob; candidate = payload):
  - `interface/main/tabs/main.php` base_matches_tag=yes candidate_hash_ok=yes
  - `library/ajax/dated_reminders_counter.php` base_matches_tag=yes candidate_hash_ok=yes
  - `src/Common/Session/SessionTracker.php` base_matches_tag=yes candidate_hash_ok=yes
  - `interface/main/main_screen.php` base_matches_tag=yes candidate_hash_ok=yes
  - `library/auth.inc.php` base_matches_tag=yes candidate_hash_ok=yes
- Install (NAS): wrapper verbs `status|install|uninstall` via the shared helper `../_nefesh-openemr840-file-hotpatch-lib-v1.sh`; env `OPENEMR_CONTAINER`.
  - Package without a wrapper: `NEFESH_PATCH_ROOT=<this folder> OPENEMR_CONTAINER=<container> sh ../_nefesh-openemr840-file-hotpatch-lib-v1.sh install`.
- Retirement rule: upstream merge alone does not retire a running hotpatch; retire only when the official OpenEMR release NEFESH actually installs contains an equivalent fix and regression validation passes.
- Install/replace note: a recreate of the container wipes all container-local hotpatches; reinstall after every recreate.
