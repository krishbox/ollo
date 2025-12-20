use role atlassian_jira__raw;
use database atlassian_jira;
use schema atlassian_jira.raw;

create stage if not exists atlassian_jira.raw.delta_share
encryption = (type = 'snowflake_sse')
;
