function afx_reset_filter(filter_type, total_time_seconds=3, on_reset=do_nothing) {
	var index = array_find_index(obj_game_control.afx_filters, method({ filter_type }, function(item) {
		return item[0] == filter_type	
	}))
	
	var filter = struct_map(global.afx_default_values, method({ total_time_seconds }, function(effects) {
		return struct_map(effects, method({ total_time_seconds }, function(final_value) {
			return new TimedInterpolator(0, final_value, total_time_seconds)
		}))
	}))
	
	if (index == -1) {
		array_push(obj_game_control.afx_filters, [filter_type, filter])
		
		return
	}
	
	array_push(obj_game_control.afx_resetting_filter_indexes, [index, on_reset])
	
	struct_foreach(filter, method({ filter, index }, function(key, struct) {
		var control_filter = obj_game_control.afx_filters[index][1][$ key]
		
		if (!is_undefined(control_filter)) {
			struct_foreach(struct, method({ control_filter, struct, filter }, function(sub_key, sub_value) {
				struct[$ sub_key].value = control_filter[$ sub_key].value
				struct[$ sub_key].initial_value = control_filter[$ sub_key].value	
			}))
		}
	}))
	
	obj_game_control.afx_filters[index] = [filter_type, filter]
}
