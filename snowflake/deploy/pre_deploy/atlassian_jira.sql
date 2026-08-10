-- ===================================================
-- DATABASE: ATLASSIAN_JIRA (Jira Ingestion Setup)
-- ===================================================
use role sysadmin;
create or alter database atlassian_jira;
create or alter schema atlassian_jira.raw;

-- Create Network Rule for Atlassian Jira Cloud Enterprise (requires SYSADMIN/SECURITYADMIN)
use role sysadmin;
create or replace network rule atlassian_jira.raw.atlassian_jira_delta_share
  type = host_port
  mode = egress
  value_list = (
    'api.atlassian.com:443',
    'atl-datalake-prod-*.s3.ap-southeast-2.amazonaws.com:443'
  )
;

-- Create Artifact Repository for Pip packages (requires SYSADMIN)
create artifact repository if not exists atlassian_jira.raw.pypi_repository
  type = pip
  api_integration = pypi_integration
;
