create or alter schema atlassian_jira.raw
with managed access
data_retention_time_in_days = 1
max_data_extension_time_in_days = 1
object_visibility = privileged;

create role if not exists atlassian_jira__raw;
grant role atlassian_jira__raw to role atlassian_jira;
grant ownership on role atlassian_jira__raw to role atlassian_jira copy current grants;
grant ownership on schema atlassian_jira.raw to role atlassian_jira__raw;

create database role if not exists atlassian_jira.raw__read;
grant database role atlassian_jira.raw__read to role atlassian_jira__raw;
grant select on all tables in schema atlassian_jira.raw to database role atlassian_jira.raw__read;
grant select on future tables in schema atlassian_jira.raw to database role atlassian_jira.raw__read;
