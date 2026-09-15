# NEFESH OpenEMR 8.4 hotpatch — PR #14007

- Purpose: Configure Orders and Results positional bind-order fix
- Associated issue: https://github.com/openemr/openemr/issues/14006
- Upstream PR: https://github.com/openemr/openemr/pull/14007
- OpenEMR baseline: `v8_4_0` / `53d885e56d4772b4e48810a1f98531c5d19a934d`
- 8.4 disposition: One-line v8_4_0 fix: prepend parent to the INSERT positional bind array.
- NAS package: `/volume2/SandboxEMR/packages/hotpatches/openemr-8.4.0/pr14007-orders-bind-order-v1`
- NAS wrapper: `/volume2/SandboxEMR/packages/nefesh-orders-bind-order-hotpatch-v1-openemr840.sh`
- NEFESH state at archive time: **SANDBOX INSTALLED + SANDBOX TESTED**; not automatically USER ACCEPTED or MAIN-READY.
- Retirement rule: remove only after an equivalent upstream fix is included in the installed official OpenEMR release and NEFESH regression validation passes.
