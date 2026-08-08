define network rule {{jira_database}}.{{schema_name}}.{{jira_database}}_delta_share
  type = host_port
  mode = egress
  value_list = (
    'api.atlassian.com:443',
    'atl-datalake-prod-*.s3.ap-southeast-2.amazonaws.com:443'
  )
;
