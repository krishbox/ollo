use role sysadmin;

create or alter warehouse kilby
	warehouse_type = standard
	warehouse_size = xsmall
	resource_constraint = standard_gen_1
	min_cluster_count = 1
	max_cluster_count = 1
	scaling_policy = economy
	auto_suspend = 120
	auto_resume = false
	enable_query_acceleration = false
;

create role if not exists compute_kilby;
grant role compute_kilby to role compute_admin;
grant ownership on role compute_kilby to role compute_admin copy current grants;

create role if not exists usage_kilby;
grant role usage_kilby to role compute_kilby;
grant ownership on role usage_kilby to role compute_kilby copy current grants;

grant usage on warehouse kilby to role usage_kilby;
