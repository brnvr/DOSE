depth = obj_hud.depth-1;

ts_on_complete = time_source_create(time_source_global, delay, time_source_units_seconds, function() {
	on_complete()
	
	if (auto_destroy) {
		instance_destroy()
	}	
})