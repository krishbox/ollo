use role accountadmin;

create or alter role create_integration;
grant role create_integration to role privilege_admin;
grant ownership on role create_integration to role privilege_admin copy current grants;

grant create integration on account to role create_integration;
