define role {{atlassian_delta_share_db}}_admin;
grant role {{atlassian_delta_share_db}}_admin to role sysadmin;

define role {{atlassian_delta_share_db}};
grant role {{atlassian_delta_share_db}} to role {{atlassian_delta_share_db}}_admin;

define database {{atlassian_delta_share_db}}
    data_retention_time_in_days = 1
    object_visibility = privileged;

grant ownership on database {{atlassian_delta_share_db}} to role {{atlassian_delta_share_db}};
