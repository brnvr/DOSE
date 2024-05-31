__callback__ = function() {
	if (array_length(objects) > 0) {
		var obj, period;
	
		obj = array_choose(objects);
		area_add_actor_3d(parent_area, x, y, z, obj, var_struct);
	
		period = random_range(min_interval, max_interval);
		
		time_source_reconfigure(__ts_create__, period, time_unit, __callback__);
		time_source_start(__ts_create__);
	}
}

__ts_create__ = time_source_create(time_source_global, 0, time_unit, __callback__);

time_source_start(__ts_create__);