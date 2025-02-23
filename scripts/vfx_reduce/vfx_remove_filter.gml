function vfx_set_filter(filter_type) {
	var index = array_find_index(obj_control.vfx_filters, method({ filter_type }, function(item) {
		return item[0] == filter_type	
	}))
	
	var filter = global.vfx_filter_functions[filter_type]()
	
	if (index == -1) {
		array_push(obj_control.vfx_filters, [filter_type, filter])
		
		return
	}
	
	struct_foreach(filter, method({ filter, index }, function(key, value) {
		filter[$ key].value = obj_control.vfx_filters[index][1][$ key].value
	}))
	
	obj_control.vfx_filters[index] = [filter_type, filter]
}

function vfx_remove_filter(filter) {
	var index = array_find_index(obj_control.vfx_filters, function(item) {
		return item[0] == filter_type	
	})
	
	if (index != -1) {
		array_delete(obj_control.vfx_filters, index, 1)
	}
}

function vfx_reduce_interpolators(interpolator_type) {
	var def = global.vfx_default_interpolator_values[$ interpolator_type]
	
	return array_reduce(vfx_filters, method ({ def, interpolator_type }, function(previous, current, index) {
		var previous_value = def
		
		if (index > 0) {
			var previous_interpolator = previous[1][$ interpolator_type]
		
			if (is_undefined(previous_interpolator)) {
				return def	
			}	
			
			previous_value = previous_interpolator.value
		}
		
		var current_interpolator = current[1][$ interpolator_type]

		var current_value = is_undefined(current_interpolator) ? def : current_interpolator.value
		
		return max(previous_value, current_value)
	}), def)
}