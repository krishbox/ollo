use role accountadmin;

create or alter role usage_pypi_shared_repository;
grant role usage_pypi_shared_repository to role privilege_admin;
grant ownership on role usage_pypi_shared_repository to role privilege_admin copy current grants;

grant database role snowflake.pypi_repository_user to role usage_pypi_shared_repository;
