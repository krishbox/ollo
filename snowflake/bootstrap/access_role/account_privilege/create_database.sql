use role accountadmin;

create role if not exists create_database;
grant role create_database to role privilege_admin;
grant ownership on role create_database to role privilege_admin copy current grants;

grant create database on account to role create_database;
