use role accountadmin;

create role if not exists manage_grants;
grant role manage_grants to role privilege_admin;
grant ownership on role manage_grants to role privilege_admin copy current grants;

grant manage grants on account to role manage_grants;
