use role sysadmin;

create role if not exists integration_admin;
grant role integration_admin to role sysadmin;
