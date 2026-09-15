# NEFESH OpenEMR 8.4 hotpatch — PR #13712

- Purpose: Idle-session final-minute warning and Stay Logged In action
- Associated issue: none linked in the upstream PR body; PR #13712 is the authoritative upstream tracker.
- Upstream PR: https://github.com/openemr/openemr/pull/13712
- OpenEMR baseline: `v8_4_0` / `53d885e56d4772b4e48810a1f98531c5d19a934d`
- 8.4 disposition: Adapted to current v8_4_0 dated_reminders_counter.php context; main.php and SessionTracker hunks retained.
- NAS package: `/volume2/SandboxEMR/packages/hotpatches/openemr-8.4.0/pr13712-session-v4`
- NAS wrapper: `/volume2/SandboxEMR/packages/nefesh-session-warning-hotpatch-v4-openemr840.sh`
- NEFESH state at archive time: **SANDBOX INSTALLED + SANDBOX TESTED**; not automatically USER ACCEPTED or MAIN-READY.
- Retirement rule: remove only after an equivalent upstream fix is included in the installed official OpenEMR release and NEFESH regression validation passes.
