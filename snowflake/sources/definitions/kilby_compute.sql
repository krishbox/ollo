define warehouse kilby
	warehouse_type = 'snowpark-optimized'
	warehouse_size = '{{wh_size}}'
	resource_constraint = memory_1x_x86
	min_cluster_count = 1
	max_cluster_count = 1
	scaling_policy = economy
	auto_suspend = 45
	auto_resume = true
	enable_query_acceleration = false
;

grant ownership on warehouse kilby to role compute_admin;

define role compute_kilby;
grant role compute_kilby to role compute_admin;

define role operate_kilby;
grant role operate_kilby to role compute_kilby;
grant operate on warehouse kilby to role operate_kilby;

define role usage_kilby;
grant role usage_kilby to role compute_kilby;
grant usage on warehouse kilby to role usage_kilby;
