#!/bin/sh
NEFESH_PATCH_ROOT=/volume2/SandboxEMR/packages/hotpatches/openemr-8.4.0/pr13710-medication-v6
export NEFESH_PATCH_ROOT
exec sh /volume2/SandboxEMR/packages/hotpatches/openemr-8.4.0/_nefesh-openemr840-file-hotpatch-lib-v1.sh "$@"
