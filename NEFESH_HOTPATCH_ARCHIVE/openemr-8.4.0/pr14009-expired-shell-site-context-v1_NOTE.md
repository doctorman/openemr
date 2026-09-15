# NEFESH OpenEMR 8.4 hotpatch — PR #14009

- Purpose: Expired main shell returns to login instead of HTTP 400
- Associated issue: https://github.com/openemr/openemr/issues/14008
- Upstream PR: https://github.com/openemr/openemr/pull/14009
- OpenEMR baseline: `v8_4_0` / `53d885e56d4772b4e48810a1f98531c5d19a934d`
- 8.4 disposition: Preserve validated site_id in the top-level shell redirect; stale token validation remains fail-closed.
- NAS package: `/volume2/SandboxEMR/packages/hotpatches/openemr-8.4.0/expired-shell-site-context-v1`
- NAS wrapper: `/volume2/SandboxEMR/packages/nefesh-expired-shell-site-hotpatch-v1-openemr840.sh`
- NEFESH state at archive time: **SANDBOX INSTALLED + SANDBOX TESTED**; not automatically USER ACCEPTED or MAIN-READY.
- Retirement rule: remove only after an equivalent upstream fix is included in the installed official OpenEMR release and NEFESH regression validation passes.
