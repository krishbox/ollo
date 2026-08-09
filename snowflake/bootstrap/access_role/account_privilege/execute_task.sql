use role accountadmin;

create or alter role execute_task;
grant role execute_task to role privilege_admin;
grant ownership on role execute_task to role privilege_admin copy current grants;

grant execute task on account to role execute_task;
