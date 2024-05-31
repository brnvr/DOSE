function room_populate(room, seed_group, block_size, base_area=4) {
	var area, n_props, n_items, n_characters;
	
	area = room.hlength*room.vlength;
	
	n_characters = 0;
	n_props = 0;
	n_items = 0;
	
	repeat(floor(area/base_area)) {
		while (take_chance(room.prob_prop)) n_props++;
		while (take_chance(room.prob_item)) n_items++;
		while (take_chance(room.prob_character)) n_characters++;
	}
	
	static create_actors = function(room, block_size, number, arr, allow_repeated=true) {
		if (!allow_repeated) {
			arr = array_create_copy(arr);	
		}
		
		for (var i = 0; i < number; i++) {
			var base_axis, wall_origin, base_axis_length, other_axis_length, min_d0, max_d0, min_d1, max_d1,
			min_r0, max_r0, inst, free_cells, coords;
			
			if (array_length(arr) == 0) {
				break;	
			}
			
			base_axis = choose(0, 1);
			wall_origin = choose(0, 1);
			
			base_axis_length = base_axis == 0 ? room.hlength : room.vlength;
			other_axis_length = base_axis == 1 ? room.hlength : room.vlength;
			inst = instance_create_layer(room.x, room.y, "Default", array_choose(arr, !allow_repeated), { z: room.z });

			min_r0 = (base_axis_length-1)*inst.room_position_factor_min;
			max_r0 = (base_axis_length-1)*inst.room_position_factor_max;
			
			min_d0 = round(wall_origin == 0 ? min_r0 : base_axis_length-1-max_r0);
			max_d0 = round(wall_origin == 0 ? max_r0 : base_axis_length-1-min_r0);
			
			min_d1 = round(inst.room_position_factor_min*other_axis_length);
			max_d1 = round((1-inst.room_position_factor_min)*other_axis_length);
			
			free_cells = room_get_free_cells_range(room,
				base_axis == 0 ? min_d0 : min_d1,
				base_axis == 0 ? min_d1 : min_d0,
				base_axis == 0 ? max_d0 : max_d1,
				base_axis == 0 ? max_d1 : max_d0);
				
			if (array_length(free_cells) == 0) {
				instance_destroy(inst);
				continue;	
			}
			
			coords = array_choose(free_cells);
			room_occupy_cell(room, coords[0], coords[1]);
			
			inst.x += (coords[0]+.5)*block_size;
			inst.y += (coords[1]+.5)*block_size;

			area_append_instance(room, inst);
		}
	}
	
	var arr_ev = array_concat(area_events, [])
	
	while (take_chance(room.prob_event) && array_length(arr_ev) > 0) {
		var ev = array_choose(arr_ev, true)
		
		if (ev(room, block_size, create_actors)) {
			return
		}
	}
	
	create_actors(room, block_size, n_items, seed_group[sg.items]);
	create_actors(room, block_size, n_props, seed_group[sg.props]);
	create_actors(room, block_size, n_characters, seed_group[sg.characters], false);
}