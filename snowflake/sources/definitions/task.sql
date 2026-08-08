define task {{jira_database}}.{{schema_name}}.jira_incremental_load
  warehouse = kilby
  schedule = 'using cron 0 12 * * * UTC'
  suspend_task_after_num_failures = 2
  allow_overlapping_execution = false
  user_task_timeout_ms = 3600000
as
  call {{jira_database}}.{{schema_name}}.copy_data_wrapper()
;
