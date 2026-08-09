use role privilege_admin;

-- Grant integration usage role to the database access roles
grant role usage_integration_atlassian_jira_delta_share to role atlassian_jira_admin;
grant role usage_integration_atlassian_jira_delta_share to role atlassian_jira__raw;

-- Upload Atlassian Delta Sharing Profile to Stage (requires atlassian_jira_admin)
use role atlassian_jira_admin;
put 'file:///Users/krishna/Documents/projects/snowflake_jira_delta_share/canvadev/profile' @atlassian_jira.raw.delta_share/ auto_compress=false overwrite=true;
