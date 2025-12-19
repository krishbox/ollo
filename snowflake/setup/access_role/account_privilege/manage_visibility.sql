use role accountadmin;

create role if not exists manage_visibility;
grant role manage_visibility to role privilege_admin;
grant ownership on role manage_visibility to role privilege_admin copy current grants;

grant manage visibility on account to role manage_visibility;
