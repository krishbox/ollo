-- ===================================================
-- DATABASE: ATLASSIAN_JIRA (Jira Ingestion Setup)
-- ===================================================
USE ROLE SYSADMIN;
CREATE DATABASE IF NOT EXISTS atlassian_jira;
CREATE SCHEMA IF NOT EXISTS atlassian_jira.raw;

-- Create PyPI integration (requires ACCOUNTADMIN)
USE ROLE ACCOUNTADMIN;
CREATE API INTEGRATION IF NOT EXISTS pypi_integration
  API_PROVIDER = pypi
  ENABLED = true
;
GRANT USAGE ON INTEGRATION pypi_integration TO ROLE SYSADMIN;

-- Create Network Rule for Atlassian Jira Cloud Enterprise (requires SYSADMIN/SECURITYADMIN)
USE ROLE SYSADMIN;
CREATE OR REPLACE NETWORK RULE atlassian_jira.raw.atlassian_jira_delta_share
  TYPE = host_port
  MODE = egress
  VALUE_LIST = (
    'api.atlassian.com:443',
    'atl-datalake-prod-*.s3.ap-southeast-2.amazonaws.com:443'
  )
;

-- Create External Access Integration (requires ACCOUNTADMIN)
USE ROLE ACCOUNTADMIN;
CREATE EXTERNAL ACCESS INTEGRATION IF NOT EXISTS atlassian_jira_delta_share
  ALLOWED_NETWORK_RULES = (atlassian_jira.raw.atlassian_jira_delta_share)
  ENABLED = true
;

-- Create Integration Role and Grant Usage (requires ACCOUNTADMIN)
CREATE ROLE IF NOT EXISTS usage_integration_atlassian_jira_delta_share;
GRANT USAGE ON INTEGRATION atlassian_jira_delta_share TO ROLE usage_integration_atlassian_jira_delta_share;

-- Create Artifact Repository for Pip packages (requires SYSADMIN)
USE ROLE SYSADMIN;
CREATE ARTIFACT REPOSITORY IF NOT EXISTS atlassian_jira.raw.pypi_repository
  TYPE = pip
  API_INTEGRATION = pypi_integration
;
