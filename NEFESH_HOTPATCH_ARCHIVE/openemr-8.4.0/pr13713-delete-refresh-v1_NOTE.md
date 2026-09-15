# NEFESH OpenEMR 8.4 hotpatch — PR #13713

- Purpose: Decouple delete refresh from SQL-display setting
- Associated issue: https://github.com/openemr/openemr/issues/13707
- Upstream PR: https://github.com/openemr/openemr/pull/13713
- OpenEMR baseline: `v8_4_0` / `53d885e56d4772b4e48810a1f98531c5d19a934d`
- 8.4 disposition: Clean carry-forward to exact v8_4_0 source. Re-review for 8.5 because upstream PR #13958 also changes deleter.php.
- NAS package: `/volume2/SandboxEMR/packages/hotpatches/openemr-8.4.0/pr13713-delete-refresh-v1`
- NAS wrapper: `/volume2/SandboxEMR/packages/nefesh-delete-refresh-hotpatch-v1-openemr840.sh`
- NEFESH state at archive time: **SANDBOX INSTALLED + SANDBOX TESTED**; not automatically USER ACCEPTED or MAIN-READY.
- Retirement rule: remove only after an equivalent upstream fix is included in the installed official OpenEMR release and NEFESH regression validation passes.
