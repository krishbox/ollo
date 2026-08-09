use role sysadmin;

create or alter role privilege_admin;
grant ownership on role privilege_admin to role sysadmin copy current grants;
grant role privilege_admin to role sysadmin;
