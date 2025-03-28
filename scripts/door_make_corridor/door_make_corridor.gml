function door_make_corridor(door, dir) {
	with (door) {
		var opposite_dir = cardinal_opposite(dir);
	
		var dest_area = actor_3d_create(0, 0, 0, obj_corridor, {
			on_build: function(corridor) {
				corridor_populate(corridor, obj_game_control.seed_group, default_block_size, obj_game_control.current_realm);
			}
		})
	
		corridor_generate(dest_area);
		
		var door_coord = corridor_get_door_coords_random(dest_area, opposite_dir);
		
		if (is_undefined(door_coord)) {
			door_coord = corridor_add_passage_random(dest_area, opposite_dir);
		} else {
			corridor_remove_door_from_cell(dest_area, door_coord[0], door_coord[1], opposite_dir);
		}
	
		for (var i = 0; i < array_length(dest_area.cells_used); i++) {
			if (array_compare(dest_area.cells_used[i], door_coord)) {
				var first_cell_used = dest_area.cells_used[0];
			
				dest_area.cells_used[0] = door_coord;
				dest_area.cells_used[i] = first_cell_used;
			
				break
			}
		}
		
		var xst = 0, yst = 0
		
		switch (dir) {
			case cardinal.east:
				xst = x-door_coord[0]*default_block_size;
				yst = y-wall_passage_width-door_coord[1]*default_block_size;
				areas[cardinal.east] = dest_area;
				break
			
			case cardinal.west:
				xst = x-(door_coord[0]+1)*default_block_size;
				yst = y-wall_passage_width-door_coord[1]*default_block_size;
				areas[cardinal.west] = dest_area;
				break
				
			case cardinal.north:
				xst = x-wall_passage_width-door_coord[0]*default_block_size;
				yst = y-(door_coord[1]+1)*default_block_size;
				areas[cardinal.north] = dest_area;
				break
				
			case cardinal.south:
				xst = x-wall_passage_width-door_coord[0]*default_block_size;
				yst = y-door_coord[1]*default_block_size;
				areas[cardinal.south] = dest_area;
				break
		}
	
		dest_area.x = xst
		dest_area.y = yst
	
		if (door_number < 0) {
			door_generate_number(id, cardinal_opposite(dir))
		}
	
		corridor_build(dest_area, obj_game_control.seed_group, default_block_size, wall_passage_width)

		return dest_area
	}
}