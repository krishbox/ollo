use role sysadmin;

create role if not exists privilege_admin;
grant ownership on role privilege_admin to role sysadmin copy current grants;
grant role privilege_admin to role sysadmin;
