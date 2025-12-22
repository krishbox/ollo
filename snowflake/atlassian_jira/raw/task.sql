use role atlassian_jira__raw;
use database atlassian_jira;
use schema atlassian_jira.raw;

-- This task calls the copy data wrapper procedure incrementally copying Jira data
create or replace task atlassian_jira.raw.jira_incremental_load
warehouse = kilby
as
call atlassian_jira.raw.copy_data_wrapper();
alter task if exists atlassian_jira.raw.jira_incremental_load suspend;
alter task if exists atlassian_jira.raw.jira_incremental_load set schedule = 'using cron 0 12 * * * UTC';
alter task if exists atlassian_jira.raw.jira_incremental_load set suspend_task_after_num_failures = 2;
alter task atlassian_jira.raw.jira_incremental_load set allow_overlapping_execution = false;
alter task atlassian_jira.raw.jira_incremental_load set user_task_timeout_ms = 3600000;

-- Enable tasks
select
  system$task_dependents_enable (
    'atlassian_jira.raw.jira_incremental_load'
  )
;
