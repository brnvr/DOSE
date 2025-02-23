function vfx_remove_filter(filter_type) {
	var index = array_find_index(obj_control.vfx_filters, method({ filter_type }, function(item) {
		return item[0] == filter_type	
	}))
	
	
	if (index != -1) {
		array_delete(obj_control.vfx_filters, index, 1)
		
		return
	}
}

