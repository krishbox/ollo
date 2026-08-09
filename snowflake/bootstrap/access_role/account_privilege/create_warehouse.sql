use role accountadmin;

create or alter role create_warehouse;
grant role create_warehouse to role privilege_admin;
grant ownership on role create_warehouse to role privilege_admin copy current grants;

grant create warehouse on account to role create_warehouse;
