{% for db in databases %}
-- ===================================================
-- DATABASE: {{db.name}}
-- ===================================================

-- 1. Database and Admin / Owner Roles
define role {{db.name}}_admin;
grant role {{db.name}}_admin to role sysadmin;

define role {{db.name}};
grant role {{db.name}} to role {{db.name}}_admin;

define database {{db.name}}
    data_retention_time_in_days = 1
    object_visibility = privileged;

grant usage on database {{db.name}} to role {{db.name}}_admin;
grant ownership on database {{db.name}} to role {{db.name}};

-- 2. Database-Level Permissions and Grants
grant role execute_task to role {{db.name}}_admin;
grant role compute_kilby to role {{db.name}}_admin;

-- ---------------------------------------------------
-- Schemas Setup for {{db.name}}
-- ---------------------------------------------------
{% for schema_name in db.schemas %}

-- 3. Schema and Schema Access Roles
define role {{db.name}}__{{schema_name}};
grant role {{db.name}}__{{schema_name}} to role {{db.name}};
grant ownership on role {{db.name}}__{{schema_name}} to role {{db.name}};
grant usage on schema {{db.name}}.{{schema_name}} to role {{db.name}}__{{schema_name}};

define schema {{db.name}}.{{schema_name}}
with managed access
data_retention_time_in_days = 1
max_data_extension_time_in_days = 1
object_visibility = privileged;

grant ownership on schema {{db.name}}.{{schema_name}} to role {{db.name}}__{{schema_name}};

define role {{db.name}}__{{schema_name}}__read;
grant ownership on role {{db.name}}__{{schema_name}}__read to role {{db.name}}__{{schema_name}};
grant role {{db.name}}__{{schema_name}}__read to role {{db.name}}__{{schema_name}};
grant inherited select on all tables in schema {{db.name}}.{{schema_name}} to role {{db.name}}__{{schema_name}}__read;

-- Schema-level Grants
grant role execute_task to role {{db.name}}__{{schema_name}};
grant role compute_kilby to role {{db.name}}__{{schema_name}};

{% endfor %}
{% endfor %}
