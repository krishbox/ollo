define procedure atlassian_jira.raw.copy_data_wrapper()
returns string not null
language sql
as
$$
begin
  let status string := 'Fail';
  call atlassian_jira.raw.copy_data('jira_component', false);
  call atlassian_jira.raw.copy_data('jira_issue_component_mapping', false);
  call atlassian_jira.raw.copy_data('jira_project_component', false);
  -- this is materialized view, so we need to reload every time
  call atlassian_jira.raw.copy_data('jira_issue_enhanced_table', true);
  call atlassian_jira.raw.copy_data('jira_issue_field', false);
  call atlassian_jira.raw.copy_data('jira_issue_field_metadata', false);
  call atlassian_jira.raw.copy_data('jira_issue_field_option', false);
  call atlassian_jira.raw.copy_data('jira_issue_fix_version_mapping', false);
  call atlassian_jira.raw.copy_data('jira_issue_history_change_item', false);
  call atlassian_jira.raw.copy_data('jira_issue_link', false);
  call atlassian_jira.raw.copy_data('jira_issue_link_type', false);
  call atlassian_jira.raw.copy_data('jira_issue_priority', false);
  call atlassian_jira.raw.copy_data('jira_issue_resolution', false);
  call atlassian_jira.raw.copy_data('jira_issue_status', false);
  call atlassian_jira.raw.copy_data('jira_issue_type', false);
  call atlassian_jira.raw.copy_data('jira_issue_worklog', false);
  call atlassian_jira.raw.copy_data('jira_project', false);
  call atlassian_jira.raw.copy_data('jira_project_category', false);
  call atlassian_jira.raw.copy_data('jira_project_version', false);
  call atlassian_jira.raw.copy_data('jira_sprint', false);
  call atlassian_jira.raw.copy_data('jsm_affected_service', false);
  call atlassian_jira.raw.copy_data('jsm_incident_responder', false);
  call atlassian_jira.raw.copy_data('jira_request_type', false);
  call atlassian_jira.raw.copy_data('jsm_sla', false);
  status := 'Success';
  return status;
end;
$$;
