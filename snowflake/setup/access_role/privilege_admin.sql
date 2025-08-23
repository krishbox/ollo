use role accountadmin;

create role if not exists privilege_admin;
grant role privilege_admin to role accountadmin;
