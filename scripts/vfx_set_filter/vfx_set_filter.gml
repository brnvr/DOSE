function vfx_set_filter(filter_type) {
	var index = array_find_index(obj_game_control.vfx_filters, method({ filter_type }, function(item) {
		return item[0] == filter_type	
	}))
	
	var filter = global.vfx_filter_functions[filter_type]()
	
	if (index == -1) {
		array_push(obj_game_control.vfx_filters, [filter_type, filter])
		
		return
	}
	
	struct_foreach(filter, method({ filter, index }, function(key, value) {
		filter[$ key].value = obj_game_control.vfx_filters[index][1][$ key].value
	}))
	
	obj_game_control.vfx_filters[index] = [filter_type, filter]
	
	var index_ = array_find_index(obj_game_control.vfx_resetting_filter_indexes, method({ index }, function(item) {
		return item[0] == index	
	}))
	
	if (index_ != -1) {
		array_delete(obj_game_control.vfx_resetting_filter_indexes, index_, 1)
	}
}

function sfx_set_filter(filter_type) {
	var index = array_find_index(obj_game_control.sfx_filters, method({ filter_type }, function(item) {
		return item[0] == filter_type	
	}))
	
	var filter = global.sfx_filter_functions[filter_type]()
	
	if (index == -1) {
		array_push(obj_game_control.sfx_filters, [filter_type, filter])
		
		return
	}
	
	struct_foreach(filter, method({ filter, index }, function(filter_item_name, filter_item) {
		struct_foreach(filter_item, method({ filter_item, index }, function() {
			filter_item.value = obj_game_control.sfx_filters[index][1][filter_item_name][$ key].value
		}))
	}))
	
	obj_game_control.sfx_filters[index] = [filter_type, filter]
	
	/*var index_ = array_find_index(obj_game_control.vfx_resetting_filter_indexes, method({ index }, function(item) {
		return item[0] == index	
	}))
	
	if (index_ != -1) {
		array_delete(obj_game_control.vfx_resetting_filter_indexes, index_, 1)
	}*/
}

