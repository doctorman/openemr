-- NEFESH backport of upstream OpenEMR master (8.5.0 line): supported_external_dataloads rows for
--   PR #14280 (FY 2027 ICD-10-CM + ICD-10-PCS, release 2026-10-01)
--   PR #13762 (April 1 2026 mid-year ICD-10-CM + PCS, release 2026-04-01)
-- Idempotent (same intent as upstream "#IfNotRow4D"): a row is inserted only when no row with the same
-- load_type / load_source / load_release_date / load_filename exists. The `version` table (v_database) is NOT touched.
INSERT INTO `supported_external_dataloads` (`load_type`, `load_source`, `load_release_date`, `load_filename`, `load_checksum`)
SELECT 'ICD10', 'CMS', '2026-10-01', '2027-code-descriptions-in-tabular-order.zip', 'd71d4467481e3396991576a02e030213' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `supported_external_dataloads` WHERE `load_type` = 'ICD10' AND `load_source` = 'CMS' AND `load_release_date` = '2026-10-01' AND `load_filename` = '2027-code-descriptions-in-tabular-order.zip');
INSERT INTO `supported_external_dataloads` (`load_type`, `load_source`, `load_release_date`, `load_filename`, `load_checksum`)
SELECT 'ICD10', 'CMS', '2026-10-01', 'zip-file-3-2027-icd-10-pcs-codes-file.zip', 'ca7dd9e61622a3b9faf766ac6b1cd15d' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `supported_external_dataloads` WHERE `load_type` = 'ICD10' AND `load_source` = 'CMS' AND `load_release_date` = '2026-10-01' AND `load_filename` = 'zip-file-3-2027-icd-10-pcs-codes-file.zip');
INSERT INTO `supported_external_dataloads` (`load_type`, `load_source`, `load_release_date`, `load_filename`, `load_checksum`)
SELECT 'ICD10', 'CMS', '2026-04-01', 'april-1-2026-code-descriptions-in-tabular-order.zip', '22700f631c4e0194467b96d0c1f83e67' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `supported_external_dataloads` WHERE `load_type` = 'ICD10' AND `load_source` = 'CMS' AND `load_release_date` = '2026-04-01' AND `load_filename` = 'april-1-2026-code-descriptions-in-tabular-order.zip');
INSERT INTO `supported_external_dataloads` (`load_type`, `load_source`, `load_release_date`, `load_filename`, `load_checksum`)
SELECT 'ICD10', 'CMS', '2026-04-01', 'zip-file-3-2026-icd-10-pcs-codes-file.zip', '3521b090d9ca58af9c8d73bbf2b3110a' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `supported_external_dataloads` WHERE `load_type` = 'ICD10' AND `load_source` = 'CMS' AND `load_release_date` = '2026-04-01' AND `load_filename` = 'zip-file-3-2026-icd-10-pcs-codes-file.zip');
