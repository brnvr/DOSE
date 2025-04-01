function vfx_reset_filter(filter_type, total_time_seconds=3, on_reset=do_nothing) {
	var index = array_find_index(obj_game_control.vfx_filters, method({ filter_type }, function(item) {
		return item[0] == filter_type	
	}))
	
	var filter = struct_map(global.vfx_default_values, method({ total_time_seconds }, function(final_value) {
		return new TimedInterpolator(0, final_value, total_time_seconds) 
	}))
	
	if (index == -1) {
		array_push(obj_game_control.vfx_filters, [filter_type, filter])
		
		return
	}
	
	array_push(obj_game_control.vfx_resetting_filter_indexes, [index, on_reset])
	
	struct_foreach(filter, method({ filter, index }, function(key, value) {
		var control_filter = obj_game_control.vfx_filters[index][1][$ key]
		
		if (!is_undefined(control_filter)) {
			filter[$ key].value = control_filter.value
			filter[$ key].initial_value = control_filter.value
		}
	}))
	
	obj_game_control.vfx_filters[index] = [filter_type, filter]
}