use role privilege_admin;

-- Grant integration usage role to the schema access role (inherited by admin role via hierarchy)
grant role usage_integration_atlassian_jira_delta_share to role atlassian_jira__raw;

-- Grant PyPI repository and integration usage roles to the schema access role (inherited by admin role via hierarchy)
grant role usage_pypi_shared_repository to role atlassian_jira__raw;
grant role usage_integration_pypi to role atlassian_jira__raw;

-- Upload Atlassian Delta Sharing Profile to Stage (requires atlassian_jira_admin)
use role atlassian_jira_admin;
put 'file:///Users/krishna/Documents/projects/snowflake_jira_delta_share/canva/profile' @atlassian_jira.raw.delta_share/ auto_compress=false overwrite=true;
