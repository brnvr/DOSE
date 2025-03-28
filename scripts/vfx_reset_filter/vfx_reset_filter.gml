function vfx_reset_filter(filter_type, remove=true, factor=1000, on_reset=do_nothing) {
	var index = array_find_index(obj_game_control.vfx_filters, method({ filter_type }, function(item) {
		return item[0] == filter_type	
	}))
	
	var filter = struct_map(global.vfx_default_values, function(final_value) {
		return new Interpolator(0, final_value, 0) 
	})
	
	if (index == -1) {
		array_push(obj_game_control.vfx_filters, [filter_type, filter])
		
		return
	}
	
	array_push(obj_game_control.vfx_resetting_filter_indexes, [index, on_reset])
	
	struct_foreach(filter, method({ filter, index, factor }, function(key, value) {
		var control_filter = obj_game_control.vfx_filters[index][1][$ key]
		
		if (!is_undefined(control_filter)) {
			filter[$ key].value = control_filter.value
			
			if (is_instanceof(control_filter, BaseInterpolator)) {
				filter[$ key].delta = abs(control_filter.value-filter[$ key].final_value)/factor	
			}
		}
	}))
	
	obj_game_control.vfx_filters[index] = [filter_type, filter]
}
