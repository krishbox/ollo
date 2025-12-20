use role privilege_admin;

grant role pypi_integration_user to role atlassian_jira_admin;
grant role usage_pypi_shared_repository to role atlassian_jira_admin;

grant role pypi_integration_user to role atlassian_jira__raw;
grant role usage_pypi_shared_repository to role atlassian_jira__raw;
