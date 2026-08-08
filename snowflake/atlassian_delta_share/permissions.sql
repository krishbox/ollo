grant role usage_pypi_shared_repository to role {{atlassian_delta_share_db}}_admin;
grant role usage_pypi_shared_repository to role {{atlassian_delta_share_db}}__{{schema_name}};
grant role execute_task to role {{atlassian_delta_share_db}}_admin;
grant role execute_task to role {{atlassian_delta_share_db}}__{{schema_name}};

grant role usage_integration_pypi to role {{atlassian_delta_share_db}}_admin;
grant role usage_integration_pypi to role {{atlassian_delta_share_db}}__{{schema_name}};
grant role usage_integration_{{atlassian_delta_share_db}} to role {{atlassian_delta_share_db}}_admin;
grant role usage_integration_{{atlassian_delta_share_db}} to role {{atlassian_delta_share_db}}__{{schema_name}};

grant role compute_kilby to role {{atlassian_delta_share_db}}_admin;
grant role compute_kilby to role {{atlassian_delta_share_db}}__{{schema_name}};
