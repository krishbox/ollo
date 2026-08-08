define role {{atlassian_delta_share_db}}__{{schema_name}};
grant role {{atlassian_delta_share_db}}__{{schema_name}} to role {{atlassian_delta_share_db}};
grant ownership on role {{atlassian_delta_share_db}}__{{schema_name}} to role {{atlassian_delta_share_db}} copy current grants;
grant ownership on schema {{atlassian_delta_share_db}}.{{schema_name}} to role {{atlassian_delta_share_db}}__{{schema_name}};

define schema {{atlassian_delta_share_db}}.{{schema_name}}
with managed access
data_retention_time_in_days = 1
max_data_extension_time_in_days = 1
object_visibility = privileged;

define database role {{atlassian_delta_share_db}}.{{schema_name}}__read;
grant database role {{atlassian_delta_share_db}}.{{schema_name}}__read to role {{atlassian_delta_share_db}}__{{schema_name}};
grant select on all tables in schema {{atlassian_delta_share_db}}.{{schema_name}} to database role {{atlassian_delta_share_db}}.{{schema_name}}__read;
grant select on future tables in schema {{atlassian_delta_share_db}}.{{schema_name}} to database role {{atlassian_delta_share_db}}.{{schema_name}}__read;
