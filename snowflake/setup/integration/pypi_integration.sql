use role sysadmin;

create api integration if not exists pypi_integration
api_provider = pypi
enabled = true;

create role if not exists pypi_integration_admin;
grant role pypi_integration_admin to role sysadmin;
grant ownership on integration pypi_integration to role pypi_integration_admin;

create role if not exists pypi_integration_user;
grant role pypi_integration_user to role pypi_integration_admin;
grant usage on integration pypi_integration to role pypi_integration_user;
