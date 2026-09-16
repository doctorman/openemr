#!/bin/sh
set -eu
NEFESH_PATCH_ROOT=/volume2/SandboxEMR/packages/hotpatches/openemr-8.4.0/pr14009-expired-shell-site-context-v2
export NEFESH_PATCH_ROOT
exec "$NEFESH_PATCH_ROOT/shared-helper-v1.sh" "${1:-status}"
