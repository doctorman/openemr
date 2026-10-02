# NEFESH OpenEMR 8.4.1 hotpatch register

**Baseline:** OpenEMR `v8_4_1` commit `a43edad9ea6d969fcbcc1df7d8ccc50ad34fd872` (2026-09-20); NEFESH docker image `openemr/openemr:8.4.1-2026-10-01`, MAIN image `nefesh/openemr:8.4.1-2026-10-01-n1` (same base plus `99-nefesh.ini` upload limit, now mounted from compose).
**Branch base:** this archive branch sits directly on the installed baseline: upstream tag `v8_4_1` (commit `a43edad9ea6d969fcbcc1df7d8ccc50ad34fd872`), so `git diff v8_4_1..HEAD` shows only the NEFESH archive files. Every stock file of every package was verified byte-identical to the `v8_4_1` blob (see each HOTPATCH_NOTE.md and manifest.psv).  
**Archive date:** 2026-10-02  
**Count:** 6 hotpatches

Each folder holds the exact candidate payload, the stock/candidate hash manifest, a unified stock-to-candidate `PATCH.diff`, the wrapper and a note. Operational install copies live on the NAS (`/volume2/SandboxEMR/packages` and `/volume2/emr_upgrade/packages`). Replaces the 8.4.0 archive for packages superseded on 8.4.1 (see `archive/nefesh-openemr840-hotpatches-20260914`).

| Hotpatch | Issue(s) | PR(s) | State | Wrapper |
|---|---|---|---|---|
| pr13710-medication-v6 | #13660 | #13710 | carried; PR open, conflicts with master (needs rebase) | `nefesh-medication-search-ui-hotpatch-v6-openemr840.sh` |
| pr13711-vitals-v3 | #13689 | #13711 | carried; PR open | `nefesh-vitals-core-hotpatch-v3-openemr840.sh` |
| pr14007-orders-bind-order-v1 | #14006 | #14007 | carried; PR open | `nefesh-orders-bind-order-hotpatch-v1-openemr840.sh` |
| pr13713-14262-delete-v2 | #13707, #14235 | #13713, #14262 | NEW 2026-10-02: supersedes pr13713-delete-refresh-v1; #14262 part retires when a release contains it | `nefesh-delete-refresh-hotpatch-v2-openemr840.sh` |
| session-shell-combined-v2 | #14008 | #13712, #14009, #14308 | NEW 2026-10-02: supersedes session-shell-combined-v1; #14308 part is an UNMERGED upstream PR | `(lib with NEFESH_PATCH_ROOT)` |
| feesheet-payer-null-v1 | #14340 | none yet | NEW 2026-10-02: issue #14340 filed by NEFESH; no PR yet | `nefesh-feesheet-payer-null-hotpatch-v1-openemr840.sh` |

## Superseded (kept only in the 8.4.0 archive branch / git history)
- pr13713-delete-refresh-v1 -> pr13713-14262-delete-v2
- session-shell-combined-v1, pr13712-session-v4, pr14009-expired-shell-site-context-v2 -> session-shell-combined-v2

## Monitoring / retirement policy
- Track every upstream PR/issue in `seats/04e-work/UPSTREAM_WATCH.md`; re-check at each OpenEMR release.
- Upstream merge alone does not retire a running hotpatch. Retirement requires inclusion in the official release actually installed by NEFESH plus targeted regression validation.
- #14308 is an UNMERGED upstream PR by another author; carrying it is a deliberate backport.
- #13713 / #14262 both change `interface/patient_file/deleter.php`; the merged v2 result is what is installed.

## Environment boundary
Installed and tested on SANDBOX (2026-10-02, UIcheck 25 rows, idle-timeout, document delete, FeeSheet checks) and rolled to MAIN on 2026-10-02 with owner authorization.
