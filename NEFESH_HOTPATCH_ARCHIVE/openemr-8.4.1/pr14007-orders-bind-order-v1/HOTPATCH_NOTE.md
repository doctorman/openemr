# NEFESH OpenEMR 8.4.1 hotpatch - pr14007-orders-bind-order-v1

- Purpose: Align procedure type insert bind order
- Associated issue(s): #14006
- Upstream PR(s): #14007
- OpenEMR baseline: `v8_4_1` / `a43edad9ea6d969fcbcc1df7d8ccc50ad34fd872` (docker image `openemr/openemr:8.4.1-2026-10-01`; every stock file below was verified byte-identical to this tag)
- Status: carried; PR open
- Files (stock hash = tag blob; candidate = payload):
  - `interface/orders/types_edit.php` base_matches_tag=yes candidate_hash_ok=yes
- Install (NAS): wrapper verbs `status|install|uninstall` via the shared helper `../_nefesh-openemr840-file-hotpatch-lib-v1.sh`; env `OPENEMR_CONTAINER`.
  - Wrapper: `nefesh-orders-bind-order-hotpatch-v1-openemr840.sh`.
- Retirement rule: upstream merge alone does not retire a running hotpatch; retire only when the official OpenEMR release NEFESH actually installs contains an equivalent fix and regression validation passes.
- Install/replace note: a recreate of the container wipes all container-local hotpatches; reinstall after every recreate.
