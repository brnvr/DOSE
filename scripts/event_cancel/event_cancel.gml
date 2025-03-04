function event_cancel(time_source_id) {
	var index = array_find(obj_event_scheduler.time_sources, time_source_id)
	
	if (index == -1) {
		return
	}
	
	time_source_stop(obj_event_scheduler.time_sources[index])
		
	array_delete(obj_event_scheduler.time_sources, index, 1)
}