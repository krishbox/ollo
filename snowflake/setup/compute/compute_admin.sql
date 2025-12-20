use role sysadmin;

create role if not exists compute_admin;
grant role compute_admin to role sysadmin;
