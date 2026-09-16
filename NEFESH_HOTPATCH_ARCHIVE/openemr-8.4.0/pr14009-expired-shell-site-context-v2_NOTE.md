# PR #14009 v2 â€” active refresh session restoration

Associated upstream issue: https://github.com/openemr/openemr/issues/14008
Associated upstream PR: https://github.com/openemr/openemr/pull/14009
Fork amendment commit: a6d173fa3134b7a4fc1eb4f6d755c3d2960f0f57

v2 supersedes the local v1 package for the same sixth tracked hotpatch. It preserves the v1 `site` shell context fix and adds a call to OpenEMR's existing `restoreSession()` during the top-level `beforeunload` path so a still-valid window restores its own session cookie before browser refresh. Token validation remains unchanged; expired/stale sessions remain fail-closed.

Validation: automated login/active-shell/stale-expiry matrix passed on SANDBOX; manual Chrome refresh acceptance passed on 2026-09-15 and remained logged in.
Baseline note: stock files in this package were extracted from the actual installed OpenEMR 8.4 Docker image used by SANDBOX.
