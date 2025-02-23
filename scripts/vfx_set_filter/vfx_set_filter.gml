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

