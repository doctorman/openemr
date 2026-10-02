# NEFESH OpenEMR 8.4.1 hotpatch - pr13711-vitals-v3

- Purpose: Improve height entry (feet/inches) and BMI refresh
- Associated issue(s): #13689
- Upstream PR(s): #13711
- OpenEMR baseline: `v8_4_1` / `a43edad9ea6d969fcbcc1df7d8ccc50ad34fd872` (docker image `openemr/openemr:8.4.1-2026-10-01`; every stock file below was verified byte-identical to this tag)
- Status: carried; PR open
- Files (stock hash = tag blob; candidate = payload):
  - `interface/forms/vitals/templates/vitals/vitals_textbox_conversion.html.twig` base_matches_tag=yes candidate_hash_ok=yes (payload has CRLF line endings; PATCH.diff ignores CR)
  - `interface/forms/vitals/vitals.css` base_matches_tag=yes candidate_hash_ok=yes (payload has CRLF line endings; PATCH.diff ignores CR)
  - `interface/forms/vitals/vitals.js` base_matches_tag=yes candidate_hash_ok=yes (payload has CRLF line endings; PATCH.diff ignores CR)
- Install (NAS): wrapper verbs `status|install|uninstall` via the shared helper `../_nefesh-openemr840-file-hotpatch-lib-v1.sh`; env `OPENEMR_CONTAINER`.
  - Wrapper: `nefesh-vitals-core-hotpatch-v3-openemr840.sh`.
- Retirement rule: upstream merge alone does not retire a running hotpatch; retire only when the official OpenEMR release NEFESH actually installs contains an equivalent fix and regression validation passes.
- Install/replace note: a recreate of the container wipes all container-local hotpatches; reinstall after every recreate.
