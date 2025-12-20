use role privilege_admin;

create role if not exists compute_admin;
grant role compute_admin to role privilege_admin;
