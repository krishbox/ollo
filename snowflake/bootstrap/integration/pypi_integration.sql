use role sysadmin;

create api integration if not exists pypi
api_provider = pypi
enabled = true;

create role if not exists usage_integration_pypi;
grant role usage_integration_pypi to role integration_admin;
grant ownership on role usage_integration_pypi to role integration_admin copy current grants;
grant usage on integration pypi to role usage_integration_pypi;
