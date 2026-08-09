{% for db_name in databases %}
-- 1. Database and Admin / Owner Roles
define role {{db_name}}_admin;
grant role {{db_name}}_admin to role sysadmin;

define role {{db_name}};
grant role {{db_name}} to role {{db_name}}_admin;

define database {{db_name}}
    data_retention_time_in_days = 1
    object_visibility = privileged;

grant usage on database {{db_name}} to role {{db_name}}_admin;
grant ownership on database {{db_name}} to role {{db_name}};

-- 2. Schema and Schema Access Roles
define role {{db_name}}__{{schema_name}};
grant role {{db_name}}__{{schema_name}} to role {{db_name}};
grant ownership on role {{db_name}}__{{schema_name}} to role {{db_name}};
grant usage on schema {{db_name}}.{{schema_name}} to role {{db_name}}__{{schema_name}};

define schema {{db_name}}.{{schema_name}}
with managed access
data_retention_time_in_days = 1
max_data_extension_time_in_days = 1
object_visibility = privileged;

grant ownership on schema {{db_name}}.{{schema_name}} to role {{db_name}}__{{schema_name}};

define role {{db_name}}__{{schema_name}}__read;
grant ownership on role {{db_name}}__{{schema_name}}__read to role {{db_name}}__{{schema_name}};
grant role {{db_name}}__{{schema_name}}__read to role {{db_name}}__{{schema_name}};
grant select on all tables in schema {{db_name}}.{{schema_name}} to role {{db_name}}__{{schema_name}}__read;
grant select on future tables in schema {{db_name}}.{{schema_name}} to role {{db_name}}__{{schema_name}}__read;

-- 3. Permissions and Grants
grant role usage_pypi_shared_repository to role {{db_name}}_admin;
grant role usage_pypi_shared_repository to role {{db_name}}__{{schema_name}};
grant role execute_task to role {{db_name}}_admin;
grant role execute_task to role {{db_name}}__{{schema_name}};

grant role usage_integration_pypi to role {{db_name}}_admin;
grant role usage_integration_pypi to role {{db_name}}__{{schema_name}};

grant role compute_kilby to role {{db_name}}_admin;
grant role compute_kilby to role {{db_name}}__{{schema_name}};

{% endfor %}
