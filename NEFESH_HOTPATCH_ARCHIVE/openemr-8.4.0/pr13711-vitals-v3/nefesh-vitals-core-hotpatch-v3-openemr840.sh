#!/bin/sh
NEFESH_PATCH_ROOT=/volume2/SandboxEMR/packages/hotpatches/openemr-8.4.0/pr13711-vitals-v3
export NEFESH_PATCH_ROOT
exec sh /volume2/SandboxEMR/packages/hotpatches/openemr-8.4.0/_nefesh-openemr840-file-hotpatch-lib-v1.sh "$@"
