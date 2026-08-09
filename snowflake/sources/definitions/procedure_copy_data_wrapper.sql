define procedure {{jira_database}}.{{schema_name}}.copy_data_wrapper()
returns string not null
language sql
as
$$
begin
  let status string := 'Fail';
  call {{jira_database}}.{{schema_name}}.copy_data('jira_component', false);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_component_mapping', false);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_project_component', false);
  -- this is materialized view, so we need to reload every time
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_enhanced_table', true);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_field', false);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_field_metadata', false);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_field_option', false);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_fix_version_mapping', false);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_history_change_item', false);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_link', false);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_link_type', false);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_priority', false);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_resolution', false);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_status', false);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_type', false);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_issue_worklog', false);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_project', false);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_project_category', false);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_project_version', false);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_sprint', false);
  call {{jira_database}}.{{schema_name}}.copy_data('jsm_affected_service', false);
  call {{jira_database}}.{{schema_name}}.copy_data('jsm_incident_responder', false);
  call {{jira_database}}.{{schema_name}}.copy_data('jira_request_type', false);
  call {{jira_database}}.{{schema_name}}.copy_data('jsm_sla', false);
  status := 'Success';
  return status;
end;
$$;
