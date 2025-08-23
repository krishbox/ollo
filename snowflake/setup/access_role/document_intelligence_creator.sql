use role accountadmin;

create role if not exists document_intelligence_creator;
grant database role snowflake.document_intelligence_creator to role document_intelligence_creator;
grant ownership on role document_intelligence_creator to role privilege_admin;
