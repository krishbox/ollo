use role sysadmin;

create role if not exists atlassian_jira_admin;
grant role atlassian_jira_admin to role sysadmin;

create role if not exists atlassian_jira;
grant role atlassian_jira to role atlassian_jira_admin;

create or alter database atlassian_jira
data_retention_time_in_days = 1
object_visibility = privileged;
grant ownership on database atlassian_jira to role atlassian_jira;

drop schema if exists atlassian_jira.public;
