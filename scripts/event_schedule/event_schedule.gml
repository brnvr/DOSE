function event_schedule(period, units, callback, parent=time_source_global) {
	var time_source = time_source_create(parent, period, units, do_nothing)
	
	time_source_reconfigure(time_source, period, units, method({ callback, time_source }, function() {
		callback()
		
		time_source_destroy(time_source)
	}))
	
	time_source_start(time_source)
	array_push(obj_event_scheduler.time_sources, time_source)
	
	return time_source
}