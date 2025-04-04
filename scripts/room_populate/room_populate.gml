function room_populate(room, seed_group, block_size, base_area, realm, area_events = global.area_events) {
	var area = room.hlength*room.vlength

	var n_characters = 0
	var n_props = 0
	var n_items = 0
	
	repeat(floor(area/base_area)) {
		while (random_event(room.prob_prop)) n_props++
		while (random_event(room.prob_item)) n_items++
		while (random_event(room.prob_character)) n_characters++
	}
	
	if ((room.hlength mod 2 != 0) && (room.vlength mod 2 != 0)) {
		room_occupy_cell(room, floor(room.hlength/2), floor(room.vlength/2))	
	}
	
	static create_actors = function(room, block_size, number, arr, allow_repeated=true, check_unique=false) {
		if (!allow_repeated) {
			arr = array_create_copy(arr)
		}
		
		for (var i = 0; i < number; i++) {
			if (array_length(arr) == 0) {
				break;	
			}
			
			var base_axis = choose(0, 1)
			var wall_origin = choose(0, 1)
			
			var base_axis_length = base_axis == 0 ? room.hlength : room.vlength
			var other_axis_length = base_axis == 1 ? room.hlength : room.vlength
			var actor_selected = array_choose(arr, !allow_repeated)
			
			if (!allow_repeated) {
				if (instance_exists(actor_selected)) {
					break	
				}	
			}
			
			var inst = instance_create_layer(room.x, room.y, "Default", actor_selected, { z: room.z })
			
			if (check_unique && inst.unique) {
				instance_destroy(inst)
				
				continue
			}

			var min_r0 = (base_axis_length-1)*inst.room_position_factor_min
			var max_r0 = (base_axis_length-1)*inst.room_position_factor_max
			
			var min_d0 = round(wall_origin == 0 ? min_r0 : base_axis_length-1-max_r0)
			var max_d0 = round(wall_origin == 0 ? max_r0 : base_axis_length-1-min_r0)
			
			var min_d1 = round(inst.room_position_factor_min*other_axis_length)
			var max_d1 = round((1-inst.room_position_factor_min)*other_axis_length)
			
			var free_cells = room_get_free_cells_range(room,
				base_axis == 0 ? min_d0 : min_d1,
				base_axis == 0 ? min_d1 : min_d0,
				base_axis == 0 ? max_d0 : max_d1,
				base_axis == 0 ? max_d1 : max_d0)
				
			if (array_length(free_cells) == 0) {
				instance_destroy(inst)
				continue
			}
			
			var coords = array_choose(free_cells)
			room_occupy_cell(room, coords[0], coords[1])
			
			inst.x += (coords[0]+.5)*block_size
			inst.y += (coords[1]+.5)*block_size

			area_append_instance(room, inst)
		}
	}
	
	var area_events_in_realm = events_in_realm(area_events, realm)
	
	var arr_ev = events_get_functions(array_concat(area_events_in_realm, []))
	
	while (random_event(room.prob_event) && array_length(arr_ev) > 0) {
		var ev = array_choose(arr_ev, true)
		
		if (ev(room, block_size, create_actors)) {
			return
		}
	}
	
	create_actors(room, block_size, n_items, seed_group[sg.items], true, false)
	create_actors(room, block_size, n_props, seed_group[sg.props])
	create_actors(room, block_size, n_characters, seed_group[sg.characters], false)
}