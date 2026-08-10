use role sysadmin;

create external access integration if not exists atlassian_jira_delta_share
allowed_network_rules = (
    atlassian_jira.raw.atlassian_jira_delta_share
)
enabled = true
;
alter external access integration if exists atlassian_jira_delta_share set
  allowed_network_rules = (
    atlassian_jira.raw.atlassian_jira_delta_share
  )
;

create role if not exists usage_integration_atlassian_jira_delta_share;
grant role usage_integration_atlassian_jira_delta_share to role integration_admin;
grant ownership on role usage_integration_atlassian_jira_delta_share to role integration_admin copy current grants;
grant usage on integration atlassian_jira_delta_share to role usage_integration_atlassian_jira_delta_share;
