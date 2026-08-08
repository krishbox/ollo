USE ROLE ACCOUNTADMIN;

-- Grant integration usage role to the database access roles
GRANT ROLE usage_integration_atlassian_jira_delta_share TO ROLE atlassian_jira_admin;
GRANT ROLE usage_integration_atlassian_jira_delta_share TO ROLE atlassian_jira__raw;

-- Upload Atlassian Delta Sharing Profile to Stage (requires atlassian_jira_admin)
USE ROLE atlassian_jira_admin;
PUT 'file:///Users/krishna/Documents/projects/snowflake_jira_delta_share/canva/profile' @atlassian_jira.raw.delta_share/ AUTO_COMPRESS=FALSE OVERWRITE=TRUE;
