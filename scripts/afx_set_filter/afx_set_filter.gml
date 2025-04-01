function afx_set_filter(filter_type, arg = undefined) {
	var index = array_find_index(obj_game_control.afx_filters, method({ filter_type }, function(item) {
		return item[0] == filter_type	
	}))
	
	var filter = global.afx_filter_functions[filter_type](arg)
	
	if (index == -1) {
		array_push(obj_game_control.afx_filters, [filter_type, filter])
		
		return
	}
	
	struct_foreach(filter, method({ filter, index }, function(filter_item_name, filter_item) {
		struct_foreach(filter_item, method({ filter_item, filter_item_name, index }, function(interpolator_name) {
			filter_item[$ interpolator_name].value = obj_game_control.afx_filters[index][1][$ filter_item_name][$ interpolator_name].value
		}))
	}))
	
	obj_game_control.afx_filters[index] = [filter_type, filter]
	
	var index_ = array_find_index(obj_game_control.afx_resetting_filter_indexes, method({ index }, function(item) {
		return item[0] == index	
	}))
	
	if (index_ != -1) {
		array_delete(obj_game_control.afx_resetting_filter_indexes, index_, 1)
	}
}