function vfx_reset_filter(filter_type, remove=true, factor=1000, on_reset=do_nothing) {
	var index = array_find_index(obj_control.vfx_filters, method({ filter_type }, function(item) {
		return item[0] == filter_type	
	}))
	
	var filter = struct_map(global.vfx_default_values, function(destination) {
		return new Interpolator(0, destination, 0) 
	})
	
	if (index == -1) {
		array_push(obj_control.vfx_filters, [filter_type, filter])
		
		return
	}
	
	array_push(obj_control.vfx_resetting_filter_indexes, [index, on_reset])
	
	struct_foreach(filter, method({ filter, index, factor }, function(key, value) {
		var control_filter = obj_control.vfx_filters[index][1][$ key]
		
		if (!is_undefined(control_filter)) {
			filter[$ key].value = control_filter.value
			
			if (is_instanceof(control_filter, Interpolator)) {
				filter[$ key].delta = abs(control_filter.value-filter[$ key].destination)/factor	
			}
		}
	}))
	
	obj_control.vfx_filters[index] = [filter_type, filter]
}

