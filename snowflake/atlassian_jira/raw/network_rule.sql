use role atlassian_jira__raw;
use database atlassian_jira;
use schema atlassian_jira.raw;

create network rule if not exists atlassian_jira.raw.atlassian_jira_delta_share
  type = host_port
  mode = egress
;
alter network rule if exists atlassian_jira.raw.atlassian_jira_delta_share set
  value_list = (
    'api.atlassian.com:443',
    'atl-datalake-prod-*.s3.ap-southeast-2.amazonaws.com:443'
  )
;
