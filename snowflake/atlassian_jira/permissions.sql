use role privilege_admin;
grant role usage_pypi_shared_repository to role atlassian_jira_admin;
grant role usage_pypi_shared_repository to role atlassian_jira__raw;
grant role execute_task to role atlassian_jira_admin;
grant role execute_task to role atlassian_jira__raw;

use role integration_admin;
grant role usage_integration_pypi to role atlassian_jira_admin;
grant role usage_integration_pypi to role atlassian_jira__raw;
grant role usage_integration_atlassian_jira_delta_share to role atlassian_jira_admin;
grant role usage_integration_atlassian_jira_delta_share to role atlassian_jira__raw;

use role compute_admin;
grant role compute_kilby to role atlassian_jira_admin;
grant role compute_kilby to role atlassian_jira__raw;
