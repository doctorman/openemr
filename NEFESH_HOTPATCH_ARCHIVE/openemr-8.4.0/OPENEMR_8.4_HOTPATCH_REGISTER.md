# NEFESH OpenEMR 8.4 hotpatch register

**Baseline:** OpenEMR `v8_4_0` commit `53d885e56d4772b4e48810a1f98531c5d19a934d`  
**Archive date:** 2026-09-14  
**Count:** 6 independent hotpatches

This archive mirrors the six current NEFESH OpenEMR 8.4 hotpatches as self-contained source bundles. The NAS copies remain the operational install copies. Each ZIP contains the exact candidate payload, exact stock/candidate hash manifest, a unified stock-to-candidate patch, the wrapper, and the shared reversible helper.

| Hotpatch | GitHub issue | GitHub PR | NEFESH runtime state | NAS wrapper |
|---|---:|---:|---|---|
| pr13710-medication-v6 | #13660 | #13710 | SANDBOX INSTALLED + TESTED | `nefesh-medication-search-ui-hotpatch-v6-openemr840.sh` |
| pr13711-vitals-v3 | #13689 | #13711 | SANDBOX INSTALLED + TESTED | `nefesh-vitals-core-hotpatch-v3-openemr840.sh` |
| pr13712-session-v4 | none linked | #13712 | SANDBOX INSTALLED + TESTED | `nefesh-session-warning-hotpatch-v4-openemr840.sh` |
| pr13713-delete-refresh-v1 | #13707 | #13713 | SANDBOX INSTALLED + TESTED | `nefesh-delete-refresh-hotpatch-v1-openemr840.sh` |
| pr14007-orders-bind-order-v1 | #14006 | #14007 | SANDBOX INSTALLED + TESTED | `nefesh-orders-bind-order-hotpatch-v1-openemr840.sh` |
| pr14009-expired-shell-site-context-v1 | #14008 | #14009 | SANDBOX INSTALLED + TESTED | `nefesh-expired-shell-site-hotpatch-v1-openemr840.sh` |

## Monitoring / retirement policy

- Keep all six hotpatches independent so they can be retired, rebased, or carried forward one at a time.
- Upstream merge alone does not retire a running hotpatch. Retirement requires inclusion in the official OpenEMR release actually installed by NEFESH plus targeted regression validation.
- PR #13713 requires semantic re-review for OpenEMR 8.5-dev because upstream PR #13958 also changes `interface/patient_file/deleter.php` for patient-context deletion hardening.
- PR #13712 has no separate issue linked from its upstream PR body; do not invent an issue association.
- Issue #13717 (concurrent code-set import race) remains a separate upstream watch item and is not one of these six installed hotpatches.

## Environment boundary

All six are recorded here as **SANDBOX INSTALLED + SANDBOX TESTED**. This archive does not constitute user acceptance, MAIN authorization, MAIN deployment, or production-PHI approval.
