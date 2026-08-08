define procedure {{jira_database}}.{{schema_name}}.copy_data_wrapper()
returns string not null
language sql
as
$$
begin
  let status string := 'Fail';
  call {{jira_database}}.{{schema_name}}.copy_data('jira_component', False);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_component_mapping', False);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_project_component', False);
  -- this is materialized view, so we need to reload every time
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_enhanced_table', True);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_field', False);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_field_metadata', False);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_field_option', False);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_fix_version_mapping', False);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_history_change_item', False);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_link', False);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_link_type', False);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_priority', False);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_resolution', False);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_status', False);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_type', False);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_worklog', False);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_project', False);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_project_category', False);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_project_version', False);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_sprint', False);
  call {{jira_database}}.{{schema_name}}.copy_data('jsm_affected_service', False);
  call {{jira_database}}.{{schema_name}}.copy_data('jsm_incident_responder', False);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_request_type', False);
  call {{jira_database}}.{{schema_name}}.copy_data('jsm_sla', False);
  status := 'Success';
  return status;
end;
$$;
