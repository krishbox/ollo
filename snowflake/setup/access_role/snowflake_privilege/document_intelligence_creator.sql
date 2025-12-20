use role accountadmin;

create role if not exists document_intelligence_creator;
grant role document_intelligence_creator to role privilege_admin;
grant ownership on role document_intelligence_creator to role privilege_admin  copy current grants;

grant database role snowflake.document_intelligence_creator to role document_intelligence_creator;
