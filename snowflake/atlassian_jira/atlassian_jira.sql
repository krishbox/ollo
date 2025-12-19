use role sysadmin;

create role if not exists atlassian_jira_admin;
grant role atlassian_jira_admin to role sysadmin;

create role if not exists atlassian_jira;
grant role atlassian_jira to role atlassian_jira_admin;

create or alter database atlassian_jira
data_retention_time_in_days = 1
object_visibility = privileged;
grant ownership on database atlassian_jira to role atlassian_jira;

use role atlassian_jira;

drop schema if exists atlassian_jira.public;

create or alter schema atlassian_jira.raw
with managed access
data_retention_time_in_days = 1
max_data_extension_time_in_days = 1
object_visibility = privileged;

create database role if not exists atlassian_jira.raw;
grant database role atlassian_jira.raw to role atlassian_jira;
grant ownership on schema atlassian_jira.raw to database role atlassian_jira.raw;

create database role if not exists atlassian_jira.raw__read;
grant select on all tables in schema atlassian_jira.raw to database role atlassian_jira.raw__read;
grant select on future tables in schema atlassian_jira.raw to database role atlassian_jira.raw__read;
