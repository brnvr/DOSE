enum corridor_cell_prop {
	type,
	lamp,
	orientation,
	occupied,
	wall_north,
	wall_south,
	wall_east,
	wall_west,
	door_north,
	door_south,
	door_east,
	door_west,
	other_ends
}

function corridor_generate(corridor, xstart=-1, ystart=-1, direction=undefined, is_continued=false) {
	var grid_size, xi, yi, n_segments, arr_changed, cont, follow, doors_single_side, doors_side;

	if (!is_continued) {
		corridor.reset();
	}

	if (is_undefined(direction)) {
		direction = choose(cardinal.south, cardinal.north, cardinal.east, cardinal.west);	
	}
	
	static build_intersection = function(corridor, xstart, ystart, direction, intersect_forward, intersect_leftward, intersect_rightward) {
		var grid_size = ds_grid_width(corridor.grid);
		
		if (xstart < 0 || xstart >= grid_size || ystart < 0 || ystart >= grid_size) {
			return undefined;	
		}

		var new_cell = [1, -1, -1, false, -1, -1, -1, -1, -1, -1, -1, -1, [noone, noone, noone, noone]];
		
		switch (direction) {
			case cardinal.south:
				if (corridor.grid[# xstart, ystart] != -1) {
					return undefined;
				}
				
				new_cell[corridor_cell_prop.wall_south] = intersect_forward ? -1 : 0;
				new_cell[corridor_cell_prop.wall_east] = intersect_leftward ? -1 : 0;
				new_cell[corridor_cell_prop.wall_west] = intersect_rightward ? -1 : 0;
				
				corridor.grid[# xstart, ystart] = new_cell;
				corridor.collision_grid[# xstart, ystart] = 1;
				array_push(corridor.cells_used, [xstart, ystart]);
				
				return [[xstart, ystart+1, cardinal.south],
						[xstart+1, ystart, cardinal.east],
						[xstart, ystart, cardinal.west]];
				
			case cardinal.north:
				if (corridor.grid[# xstart, ystart-1] != -1) {
					return undefined;
				}
				
				new_cell[corridor_cell_prop.wall_north] = intersect_forward ? -1 : 0;
				new_cell[corridor_cell_prop.wall_west] = intersect_leftward ? -1 : 0;
				new_cell[corridor_cell_prop.wall_east] = intersect_rightward ? -1 : 0;
				
				corridor.grid[# xstart, ystart-1] = new_cell;
				corridor.collision_grid[# xstart, ystart-1] = 1;
				array_push(corridor.cells_used, [xstart, ystart-1]);
				
				return [[xstart, ystart-1, cardinal.north],
						[xstart, ystart-1, cardinal.west],
						[xstart+1, ystart-1, cardinal.east]];
				
			case cardinal.east:
				if (corridor.grid[# xstart, ystart] != -1) {
					return undefined;
				}
				
				new_cell[corridor_cell_prop.wall_east] = intersect_forward ? -1 : 0;
				new_cell[corridor_cell_prop.wall_north] = intersect_leftward ? -1 : 0;
				new_cell[corridor_cell_prop.wall_south] = intersect_rightward ? -1 : 0;
				
				corridor.grid[# xstart, ystart] = new_cell;
				corridor.collision_grid[# xstart, ystart] = 1;
				array_push(corridor.cells_used, [xstart, ystart]);
				
				return [[xstart+1, ystart, cardinal.east],
						[xstart, ystart, cardinal.north],
						[xstart, ystart+1, cardinal.south]];
				
			case cardinal.west:
				if (corridor.grid[# xstart-1, ystart] != -1) {
					return undefined;
				}
				
				new_cell[corridor_cell_prop.wall_west] = intersect_forward ? -1 : 0;
				new_cell[corridor_cell_prop.wall_south] = intersect_leftward ? -1 : 0;
				new_cell[corridor_cell_prop.wall_north] = intersect_rightward ? -1 : 0;
				
				corridor.grid[# xstart-1, ystart] = new_cell;
				corridor.collision_grid[# xstart-1, ystart] = 1;
				array_push(corridor.cells_used, [xstart-1, ystart]);
				
				return [[xstart-1, ystart, cardinal.west],
						[xstart-1, ystart+1, cardinal.south],
						[xstart-1, ystart, cardinal.north]];
		}
		
		
	}
	
	static build_segment = function(corridor, xstart, ystart, doors_side, direction) {
		var pos = []
		var grid_size = ds_grid_width(corridor.grid)
		
		if (xstart < 3 || xstart >= grid_size-3 || ystart < 3 || ystart >= grid_size-3) {
			return undefined;	
		}
		
		static new_cell = function() {
			return [0, -1, -1, false, -1, -1, -1, -1, -1, -1, -1, -1, [noone, noone, noone, noone]];
		}
		
		switch (direction) {
			case cardinal.south:
				if (ystart+3 >= grid_size) return;
				
				pos =	[[xstart, ystart],
						 [xstart, ystart+1], 
						 [xstart, ystart+2],
						 [xstart, ystart+3]];
				break;
				
			case cardinal.north:
				pos =	[[xstart, ystart-1],
						 [xstart, ystart-2], 
						 [xstart, ystart-3],
						 [xstart, ystart-3]]; 
				break;
				
			case cardinal.east:
				pos =	[[xstart,   ystart],
						 [xstart+1, ystart], 
						 [xstart+2, ystart],
						 [xstart+3, ystart]];
				break;
			case cardinal.west:
				pos =	[[xstart-1, ystart],
						 [xstart-2, ystart], 
						 [xstart-3, ystart],
						 [xstart-3, ystart]];
				break;
		}
		
		for (var i = 0; i < 3; i++) {
			if (corridor.grid[# pos[i][0], pos[i][1]] != -1) {
				return undefined;
			}
		}
		
		for (var i = 0; i < 3; i++) {
			corridor.grid[# pos[i][0], pos[i][1]] = new_cell();
			corridor.collision_grid[# pos[i][0], pos[i][1]] = 1;
			array_push(corridor.cells_used, [pos[i][0], pos[i][1]]);
		}
		
		var build_staircase = take_chance(corridor.prob_staircase);
		var build_door = build_staircase ? false : take_chance(corridor.prob_door_seg);

		if (direction == cardinal.west || direction == cardinal.east) {
			corridor.grid[# pos[0][0], pos[0][1]][corridor_cell_prop.wall_north] = 0;
			corridor.grid[# pos[0][0], pos[0][1]][corridor_cell_prop.wall_south] = 0;
			corridor.grid[# pos[0][0], pos[0][1]][corridor_cell_prop.orientation] = alignment.horizontal;
			corridor.grid[# pos[1][0], pos[1][1]][corridor_cell_prop.wall_north] = 0;
			corridor.grid[# pos[1][0], pos[1][1]][corridor_cell_prop.wall_south] = 0;
			corridor.grid[# pos[1][0], pos[1][1]][corridor_cell_prop.orientation] = alignment.horizontal;
			corridor.grid[# pos[2][0], pos[2][1]][corridor_cell_prop.wall_north] = 0;
			corridor.grid[# pos[2][0], pos[2][1]][corridor_cell_prop.wall_south] = 0;
			corridor.grid[# pos[2][0], pos[2][1]][corridor_cell_prop.orientation] = alignment.horizontal;
			
			if (build_door) {
				if (doors_side == 0 || doors_side == 1) {
					corridor.grid[# pos[1][0], pos[1][1]][corridor_cell_prop.wall_north] = 1;
					corridor.grid[# pos[1][0], pos[1][1]][corridor_cell_prop.door_north] = 0;
					
					array_push(corridor.door_coords[cardinal.north], [pos[1][0], pos[1][1]]);
				}
				
				if (doors_side == 0 || doors_side == 2) {
					corridor.grid[# pos[1][0], pos[1][1]][corridor_cell_prop.wall_south] = 1;
					corridor.grid[# pos[1][0], pos[1][1]][corridor_cell_prop.door_south] = 0;
					
					array_push(corridor.door_coords[cardinal.south], [pos[1][0], pos[1][1]]);
				}
			}
			
			if (build_staircase) {
				var side;
				
				side = choose(0, 1);
				
				if (side == 0) {
					corridor.grid[# pos[1][0], pos[1][1]][corridor_cell_prop.wall_north] = 2;
					array_push(corridor.staircase_coords[cardinal.north], [pos[1][0], pos[1][1]]); 
				} else {
					corridor.grid[# pos[1][0], pos[1][1]][corridor_cell_prop.wall_south] = 2;
					array_push(corridor.staircase_coords[cardinal.south], [pos[1][0], pos[1][1]]); 
				}
			}
		} else {
			corridor.grid[# pos[0][0], pos[0][1]][corridor_cell_prop.wall_west] = 0;
			corridor.grid[# pos[0][0], pos[0][1]][corridor_cell_prop.wall_east] = 0;
			corridor.grid[# pos[0][0], pos[0][1]][corridor_cell_prop.orientation] = alignment.vertical;
			corridor.grid[# pos[1][0], pos[1][1]][corridor_cell_prop.wall_west] = 0;
			corridor.grid[# pos[1][0], pos[1][1]][corridor_cell_prop.wall_east] = 0;
			corridor.grid[# pos[1][0], pos[1][1]][corridor_cell_prop.orientation] = alignment.vertical;
			corridor.grid[# pos[2][0], pos[2][1]][corridor_cell_prop.wall_west] = 0;
			corridor.grid[# pos[2][0], pos[2][1]][corridor_cell_prop.wall_east] = 0;
			corridor.grid[# pos[2][0], pos[2][1]][corridor_cell_prop.orientation] = alignment.vertical;
			
			if (build_door) {
				if (doors_side == 0 || doors_side == 1) {
					corridor.grid[# pos[1][0], pos[1][1]][corridor_cell_prop.wall_west] = 1;	
					corridor.grid[# pos[1][0], pos[1][1]][corridor_cell_prop.door_west] = 0;
					
					array_push(corridor.door_coords[cardinal.west], [pos[1][0], pos[1][1]]);
				}
				
				if (doors_side == 0 || doors_side == 2) {
					corridor.grid[# pos[1][0], pos[1][1]][corridor_cell_prop.wall_east] = 1;
					corridor.grid[# pos[1][0], pos[1][1]][corridor_cell_prop.door_east] = 0;
					
					array_push(corridor.door_coords[cardinal.east], [pos[1][0], pos[1][1]]);
				}
			}
			
			if (build_staircase) {
				var side = choose(0, 1);
				
				if (side == 0) {
					corridor.grid[# pos[1][0], pos[1][1]][corridor_cell_prop.wall_west] = 2;
					array_push(corridor.staircase_coords[cardinal.west], [pos[1][0], pos[1][1]]); 
				} else {
					corridor.grid[# pos[1][0], pos[1][1]][corridor_cell_prop.wall_east] = 2;
					array_push(corridor.staircase_coords[cardinal.east], [pos[1][0], pos[1][1]]); 
				}
				
				
			}
		}
		
		corridor.grid[# pos[1][0], pos[1][1]][corridor_cell_prop.lamp] = 0;
		
		return pos[3];
	}
	
	static set_wall_or_passage = function(corridor, xpos, ypos, prob_door, direction) {
		var is_door = take_chance(prob_door);
		
		switch (direction) {
			case cardinal.north:
				if (is_door) {
					corridor.grid[# xpos, ypos][corridor_cell_prop.wall_north] = 1;
					corridor.grid[# xpos, ypos][corridor_cell_prop.door_north] = 0;
					
					array_push(corridor.door_coords[cardinal.north], [xpos, ypos]);
				} else {
					corridor.grid[# xpos, ypos][corridor_cell_prop.wall_north] = 0;	
				}
				
				break;
				
			case cardinal.south:
				if (is_door) {
					corridor.grid[# xpos, ypos][corridor_cell_prop.wall_south] = 1;
					corridor.grid[# xpos, ypos][corridor_cell_prop.door_south] = 0;
					
					array_push(corridor.door_coords[cardinal.south], [xpos, ypos]);
				} else {
					corridor.grid[# xpos, ypos][corridor_cell_prop.wall_south] = 0;	
				}
				
				break;
				
			case cardinal.east:
				if (is_door) {
					corridor.grid[# xpos, ypos][corridor_cell_prop.wall_east] = 1;
					corridor.grid[# xpos, ypos][corridor_cell_prop.door_east] = 0;
					
					array_push(corridor.door_coords[cardinal.east], [xpos, ypos]);
				} else {
					corridor.grid[# xpos, ypos][corridor_cell_prop.wall_east] = 0;	
				}
				
				break;
				
			case cardinal.west:
				if (is_door) {
					corridor.grid[# xpos, ypos][corridor_cell_prop.wall_west] = 1;
					corridor.grid[# xpos, ypos][corridor_cell_prop.door_west] = 0;
					
					array_push(corridor.door_coords[cardinal.west], [xpos, ypos]);
				} else {
					corridor.grid[# xpos, ypos][corridor_cell_prop.wall_west] = 0;	
				}
				
				break;
		}
	}
	
	grid_size = ds_grid_width(corridor.grid);
	
	if (xstart == -1) {
		xstart = floor(grid_size*.5);
	}
	
	if (ystart == -1) {
		ystart = floor(grid_size*.5);
	}
	
	arr_changed = [];
	
	xi = xstart;
	yi = ystart;
	
	n_segments = irandom_range(corridor.min_segments, corridor.max_segments);
	
	corridor.n_segments = n_segments;
	
	cont = true;
	follow = true;
	
	doors_single_side = take_chance(corridor.prob_doors_single_side);
	doors_side = doors_single_side ? choose(1, 2) : 0;
	
	while (cont) {
		cont = take_chance(corridor.prob_cont);
		
		if (follow) {
			var end_position = [];
			
			repeat (n_segments) {
				end_position = build_segment(corridor, xi, yi, doors_side, direction);
		
				if (is_undefined(end_position)) {
					cont = false;
					break;
				}
				
				xi = end_position[0];
				yi = end_position[1];
			}
			
			follow = take_chance(corridor.prob_follow);
		} else {
			var intersect_forward = take_chance(corridor.prob_intersect);
			var intersect_leftward = take_chance(corridor.prob_intersect);
			var intersect_rightward = take_chance(corridor.prob_intersect);
			
			var intersection_data = build_intersection(corridor, xi, yi, direction, intersect_forward, intersect_leftward, intersect_rightward)
			
			if (is_undefined(intersection_data)) {
				cont = false;			
			} else {
				if (intersect_forward) {
					corridor_generate(corridor, intersection_data[0][0], intersection_data[0][1], intersection_data[0][2], true)
				}
			
				if (intersect_leftward) {
					corridor_generate(corridor, intersection_data[1][0], intersection_data[1][1], intersection_data[1][2], true)
				}
			
				if (intersect_rightward) {
					corridor_generate(corridor, intersection_data[2][0], intersection_data[2][1], intersection_data[2][2], true)
				}

				break;
			}
		}	
			
		if (!cont) {
			switch (direction) {
				case cardinal.south:
					set_wall_or_passage(corridor, xi, yi-1, corridor.prob_door_end, cardinal.south);
					break;
			
				case cardinal.north:
					set_wall_or_passage(corridor, xi, yi, corridor.prob_door_end, cardinal.north);
					break;
			
				case cardinal.east:
					set_wall_or_passage(corridor, xi-1, yi, corridor.prob_door_end, cardinal.east);
					break;
			
				case cardinal.west:
					set_wall_or_passage(corridor, xi, yi, corridor.prob_door_end, cardinal.west);
					break;
			}	
		}
	}
	
	if (!is_continued) {
		switch (direction) {
			case cardinal.south:
				set_wall_or_passage(corridor, xstart, ystart, corridor.prob_door_end, cardinal.north);
				break;
			
			case cardinal.north:
				set_wall_or_passage(corridor, xstart, ystart-1, corridor.prob_door_end, cardinal.south);
				break;
			
			case cardinal.east:
				set_wall_or_passage(corridor, xstart, ystart, corridor.prob_door_end, cardinal.west);
				break;
			
			case cardinal.west:
				set_wall_or_passage(corridor, xstart-1, ystart, corridor.prob_door_end, cardinal.east);
				break;
		}
	}
}