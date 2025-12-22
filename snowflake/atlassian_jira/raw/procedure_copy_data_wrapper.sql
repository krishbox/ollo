use role atlassian_jira__raw;
use database atlassian_jira;
use schema atlassian_jira.raw;

create or replace procedure atlassian_jira.raw.copy_data_wrapper()
returns string not null
language sql
as
$$
begin
  let status string := 'Fail';
  call atlassian_jira.raw.copy_data('jira_component', False);
  call atlassian_jira.raw.copy_data('jira_issue_component_mapping', False);
  call atlassian_jira.raw.copy_data('jira_project_component', False);
  -- this is materialized view, so we need to reload every time
  call atlassian_jira.raw.copy_data('jira_issue_enhanced_table', True);
  call atlassian_jira.raw.copy_data('jira_issue_field', False);
  call atlassian_jira.raw.copy_data('jira_issue_field_metadata', False);
  call atlassian_jira.raw.copy_data('jira_issue_field_option', False);
  call atlassian_jira.raw.copy_data('jira_issue_fix_version_mapping', False);
  call atlassian_jira.raw.copy_data('jira_issue_history_change_item', False);
  call atlassian_jira.raw.copy_data('jira_issue_link', False);
  call atlassian_jira.raw.copy_data('jira_issue_link_type', False);
  call atlassian_jira.raw.copy_data('jira_issue_priority', False);
  call atlassian_jira.raw.copy_data('jira_issue_resolution', False);
  call atlassian_jira.raw.copy_data('jira_issue_status', False);
  call atlassian_jira.raw.copy_data('jira_issue_type', False);
  call atlassian_jira.raw.copy_data('jira_issue_worklog', False);
  call atlassian_jira.raw.copy_data('jira_project', False);
  call atlassian_jira.raw.copy_data('jira_project_category', False);
  call atlassian_jira.raw.copy_data('jira_project_version', False);
  call atlassian_jira.raw.copy_data('jira_sprint', False);
  call atlassian_jira.raw.copy_data('jsm_affected_service', False);
  call atlassian_jira.raw.copy_data('jsm_incident_responder', False);
  call atlassian_jira.raw.copy_data('jira_request_type', False);
  call atlassian_jira.raw.copy_data('jsm_sla', False);
  status := 'Success';
  return status;
end;
$$;
