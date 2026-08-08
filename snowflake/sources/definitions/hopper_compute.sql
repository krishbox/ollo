define warehouse hopper
	warehouse_type = 'standard'
	warehouse_size = xsmall
  generation = '1'
	resource_constraint = standard_gen_1
	min_cluster_count = 1
	max_cluster_count = 1
	scaling_policy = economy
	auto_suspend = 120
	auto_resume = true
	enable_query_acceleration = false
;

define role compute_hopper;
grant role compute_hopper to role compute_admin;

define role operate_hopper;
grant role operate_hopper to role compute_hopper;
grant operate on warehouse hopper to role operate_hopper;

define role usage_hopper;
grant role usage_hopper to role compute_hopper;
grant usage on warehouse hopper to role usage_hopper;
