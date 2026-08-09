-- ===================================================
-- ACCOUNT SETUP & GENERAL CONFIGURATIONS
-- ===================================================
use role accountadmin;

-- ---------------------------------------------------
-- Section 1: Enable Preview Features
-- ---------------------------------------------------

-- Enable general preview access for the account (if not already enabled)
select system$enable_preview_access();

-- Enable Inherited Grants and Container-level MANAGE GRANTS
alter account set feature_rbac_inherited_grants = 'ENABLED';

-- ---------------------------------------------------
-- Section 2: Security & Resource Management
-- ---------------------------------------------------

-- Block data exfiltration to unregistered cloud locations
alter account set prevent_unload_to_inline_url = true;

-- Block data extraction to internal stages (stops local download via GET)
alter account set prevent_unload_to_internal_stages = true;

-- Mandate storage integrations for stages (protect keys)
alter account set require_storage_integration_for_stage_creation = true;

-- Abort queries immediately when connection drops (save cost)
alter account set abort_detached_query = true;

-- ---------------------------------------------------
-- Section 3: Cost Control & Resource Guardrails
-- ---------------------------------------------------

-- Automatically cancel queries running longer than 5 minutes (300 seconds)
alter account set statement_timeout_in_seconds = 300;

-- Cancel queries queued for more than 10 minutes (600 seconds)
alter account set statement_queued_timeout_in_seconds = 600;

-- ---------------------------------------------------
-- Section 4: Encryption and Key Management
-- ---------------------------------------------------

-- Enforce stronger 256-bit AES encryption for staged file uploads
alter account set client_encryption_key_size = 256;

-- Enable continuous periodic data re-keying for data-at-rest
alter account set periodic_data_rekeying = true;

-- ---------------------------------------------------
-- Section 5: Standards & Connection Security
-- ---------------------------------------------------

-- Enforce UTC timezone globally for all session operations and schedules
alter account set timezone = 'UTC';

-- ---------------------------------------------------
-- Section 6: Diagnostics & Troubleshooting
-- ---------------------------------------------------

-- Show full unredacted SQL query text for failed syntax errors in logs
alter account set enable_unredacted_query_syntax_error = true;

-- ---------------------------------------------------
-- Section 7: AI & Machine Learning Enablement
-- ---------------------------------------------------

-- Enable secure cross-region routing for Snowflake Cortex AI LLM functions
alter account set cortex_enabled_cross_region = 'any_region';

-- ---------------------------------------------------
-- Section 8: Transaction & Date-Time Standards
-- ---------------------------------------------------

-- Terminate queries waiting for a resource/table lock after 10 minutes (600 seconds)
alter account set lock_timeout = 600;

-- Standardize global timestamp formatting to include 3 decimal fractions and timezone offsets
alter account set timestamp_output_format = 'YYYY-MM-DD HH24:MI:SS.FF3 TZHTZM';

-- ---------------------------------------------------
-- Section 9: Authentication & Developer Experience
-- ---------------------------------------------------

-- Cache MFA tokens for client connections (e.g. snow CLI, SnowSQL) for 4 hours
alter account set allow_client_mfa_caching = true;
