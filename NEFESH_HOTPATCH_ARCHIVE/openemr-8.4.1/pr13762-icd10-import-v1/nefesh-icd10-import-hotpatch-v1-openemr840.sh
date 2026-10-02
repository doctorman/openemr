#!/bin/sh
NEFESH_PATCH_ROOT=/volume2/SandboxEMR/packages/hotpatches/openemr-8.4.1/pr13762-icd10-import-v1
export NEFESH_PATCH_ROOT
exec sh /volume2/SandboxEMR/packages/hotpatches/openemr-8.4.0/_nefesh-openemr840-file-hotpatch-lib-v1.sh "$@"
