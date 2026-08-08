use role sysadmin;

create external access integration if not exists {{jira_database}}_delta_share
allowed_network_rules = (
    {{jira_database}}.{{schema_name}}.{{jira_database}}_delta_share
)
enabled = true
;
alter external access integration if exists {{jira_database}}_delta_share set
  allowed_network_rules = (
    {{jira_database}}.{{schema_name}}.{{jira_database}}_delta_share
  )
;

create role if not exists usage_integration_{{jira_database}}_delta_share;
grant role usage_integration_{{jira_database}}_delta_share to role integration_admin;
grant ownership on role usage_integration_{{jira_database}}_delta_share to role integration_admin copy current grants;
grant usage on integration {{jira_database}}_delta_share to role usage_integration_{{jira_database}}_delta_share;
