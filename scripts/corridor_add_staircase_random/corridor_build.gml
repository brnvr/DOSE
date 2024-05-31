function corridor_build(corridor, xstart, ystart, z, wall_list, door_list, block_size, prob_door_locked=.25) {
	var wall, door, n_cells;
	
	wall = array_choose(wall_list);
	door = array_choose(door_list);
	n_cells = array_length(corridor.cells_used);
	
	for (var i = 0; i < n_cells; i++) {
		var cell_coord, cell, xpos, ypos;
		
		cell_coord = corridor.cells_used[i];
		cell = corridor.grid[# cell_coord[0], cell_coord[1]];
		
		xpos = xstart + block_size*cell_coord[0];
		ypos = ystart + block_size*cell_coord[1];
		
		if (cell.wall_east >= 0) {
			instance_create_3d(xpos+block_size, ypos, z, obj_wall_generic, {
				zrotation: 0,
				sprite_index: wall,
				passage: cell.wall_east == 1
			});
		}
		
		if (cell.wall_west >= 0) {
			instance_create_3d(xpos, ypos+block_size, z, obj_wall_generic, {
				zrotation: 180,
				sprite_index: wall,
				passage: cell.wall_west == 1
			});
		}
		
		if (cell.wall_north >= 0) {
			instance_create_3d(xpos, ypos, z, obj_wall_generic, {
				zrotation: 90,
				sprite_index: wall,
				passage: cell.wall_north == 1
			});
		}
		
		if (cell.wall_south >= 0) {
			instance_create_3d(xpos+block_size, ypos+block_size, z, obj_wall_generic, {
				zrotation: 270,
				sprite_index: wall,
				passage: cell.wall_south == 1
			});
		}
		
		if (cell.door_east == 0) {
			instance_create_3d(xpos+block_size, ypos+80, z, obj_door_hinged_generic, {
				zrotation: 0,
				sprite_index: door,
				opening_direction: angular.counterclockwise,
				cardinal_direction: cardinal.east,
				locked: random(1) <= prob_door_locked,
				owner: corridor
			});
		}
		
		if (cell.door_west == 0) {
			instance_create_3d(xpos, ypos+80, z, obj_door_hinged_generic, {
				zrotation: 0,
				sprite_index: door,
				opening_direction: angular.clockwise,
				cardinal_direction: cardinal.west,
				locked: random(1) <= prob_door_locked,
				owner: corridor
			});
		}
		
		if (cell.door_north == 0) {
			instance_create_3d(xpos+80, ypos, z, obj_door_hinged_generic, {
				zrotation: 90,
				sprite_index: door,
				opening_direction: angular.counterclockwise,
				cardinal_direction: cardinal.north,
				locked: random(1) <= prob_door_locked,
				owner: corridor
			});
		}
		
		if (cell.door_south == 0) {
			instance_create_3d(xpos+80, ypos+block_size, z, obj_door_hinged_generic, {
				zrotation: 90,
				sprite_index: door,
				opening_direction: angular.clockwise,
				cardinal_direction: cardinal.south,
				locked: random(1) <= prob_door_locked,
				owner: corridor
			});
		}
	}
}

