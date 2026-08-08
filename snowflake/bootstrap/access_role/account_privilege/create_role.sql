use role accountadmin;

create role if not exists create_role;
grant role create_role to role privilege_admin;
grant ownership on role create_role to role privilege_admin copy current grants;

grant create role on account to role create_role;
