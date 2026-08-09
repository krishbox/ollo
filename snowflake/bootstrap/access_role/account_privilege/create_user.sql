use role accountadmin;

create or alter role create_user;
grant role create_user to role privilege_admin;
grant ownership on role create_user to role privilege_admin copy current grants;

grant create user on account to role create_user;
