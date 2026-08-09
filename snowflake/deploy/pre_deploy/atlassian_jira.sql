-- ===================================================
-- DATABASE: ATLASSIAN_JIRA (Jira Ingestion Setup)
-- ===================================================
use role sysadmin;
create database if not exists atlassian_jira;
create schema if not exists atlassian_jira.raw;

-- Create PyPI integration (requires ACCOUNTADMIN)
use role accountadmin;
create api integration if not exists pypi_integration
  api_provider = pypi
  enabled = true
;
grant usage on integration pypi_integration to role sysadmin;

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

-- Create External Access Integration (requires ACCOUNTADMIN)
use role accountadmin;
create external access integration if not exists atlassian_jira_delta_share
  allowed_network_rules = (atlassian_jira.raw.atlassian_jira_delta_share)
  enabled = true
;

-- Create Integration Role and Grant Usage (requires ACCOUNTADMIN)
create role if not exists usage_integration_atlassian_jira_delta_share;
grant usage on integration atlassian_jira_delta_share to role usage_integration_atlassian_jira_delta_share;

-- Create Artifact Repository for Pip packages (requires SYSADMIN)
use role sysadmin;
create artifact repository if not exists atlassian_jira.raw.pypi_repository
  type = pip
  api_integration = pypi_integration
;
