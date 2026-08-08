use role sysadmin;

create or alter warehouse hopper
	warehouse_type = 'standard'
	warehouse_size = xsmall
  generation = '1'
	resource_constraint = standard_gen_1
	min_cluster_count = 1
	max_cluster_count = 1
	scaling_policy = economy
	auto_suspend = 120
	auto_resume = false
	enable_query_acceleration = false
;

create role if not exists compute_hopper;
grant role compute_hopper to role compute_admin;
grant ownership on role compute_hopper to role compute_admin copy current grants;

create role if not exists operate_hopper;
grant role operate_hopper to role compute_hopper;
grant ownership on role operate_hopper to role compute_hopper copy current grants;
grant operate on warehouse hopper to role operate_hopper;

create role if not exists usage_hopper;
grant role usage_hopper to role compute_hopper;
grant ownership on role usage_hopper to role compute_hopper copy current grants;
grant usage on warehouse hopper to role usage_hopper;
