function corridor_build(corridor, seed_group, block_size, door_passage_side_width) {
	var wall = array_choose(seed_group[sg.walls]);
	var door = array_choose(seed_group[sg.doors]);
	var lamp = array_choose(seed_group[sg.lamps]);
	var n_cells = array_length(corridor.cells_used);
	var cell_start = corridor.cell_processing;
	var cell_end = corridor.cell_processing+corridor.cells_to_process_per_step;
	corridor.started_building = true;
	
	static staircase_get_direction = function(other_end) {
		if (other_end == noone) {
			return choose(stairs_directions.up, stairs_directions.down);	
		}
		
		return 1 - other_end.dir;
	}
	
	for (var i = cell_start; i < min(n_cells, cell_end); i++) {
		corridor.cell_processing++;
		
		var cell_coord = corridor.cells_used[i];
		var cell = corridor.grid[# cell_coord[0], cell_coord[1]];
		
		var xpos = corridor.x + block_size*cell_coord[0];
		var ypos = corridor.y + block_size*cell_coord[1];
		
		if (cell[corridor_cell_prop.door_east] >= 0 ||
			cell[corridor_cell_prop.door_west] >= 0 ||
			cell[corridor_cell_prop.door_north] >= 0 ||
			cell[corridor_cell_prop.door_south] >= 0 ||
			cell[corridor_cell_prop.wall_east] > 0 ||
			cell[corridor_cell_prop.wall_west] > 0 ||
			cell[corridor_cell_prop.wall_north] > 0 ||
			cell[corridor_cell_prop.wall_south] > 0) {
			cell[corridor_cell_prop.occupied] = true;			
		}
		
		if (cell[corridor_cell_prop.wall_east] == 2 && !obj_player.has_finished_tasks) {
			var other_end = cell[corridor_cell_prop.other_ends][cardinal.east]
			var stairs_dir = staircase_get_direction(other_end)
			
			area_add_actor_3d(corridor, xpos+block_size, ypos, corridor.z, obj_staircase_generic, {
				zrotation: 0,
				other_end: other_end,
				dir: stairs_dir,
				cardinal_direction: cardinal.east,
				orientation: cell[corridor_cell_prop.orientation],
				areas: other_end == noone ? [corridor] : other_end.areas
			});
			
			area_add_actor_3d(corridor, xpos+block_size, ypos, corridor.z, obj_wall_generic, {
				zrotation: 90,
				collidable: false,
				sprite_index: wall
			});
			
			area_add_actor_3d(corridor, xpos+block_size*2, ypos+block_size, corridor.z, obj_wall_generic, {
				zrotation: 270,
				collidable: false,
				sprite_index: wall
			});
			
			if (stairs_dir == stairs_directions.down) {
				area_add_actor_3d(corridor, xpos+block_size, ypos, corridor.z+default_block_size, obj_wall_generic, {
					zrotation: 90,
					collidable: false,
					sprite_index: wall
				});
			
				area_add_actor_3d(corridor, xpos+block_size*2, ypos+block_size, corridor.z+default_block_size, obj_wall_generic, {
					zrotation: 270,
					collidable: false,
					sprite_index: wall
				});
			}
		} else
		if (cell[corridor_cell_prop.wall_east] >= 0) {
			area_add_actor_3d(corridor, xpos+block_size, ypos, corridor.z, obj_wall_random_generic, {
				zrotation: 0,
				sprite_index: wall,
				passage: cell[corridor_cell_prop.wall_east] == 1
			});
		}
		
		if (cell[corridor_cell_prop.wall_west] == 2 && !obj_player.has_finished_tasks) {
			var other_end = cell[corridor_cell_prop.other_ends][cardinal.west]
			var stairs_dir = staircase_get_direction(other_end)
			
			area_add_actor_3d(corridor, xpos, ypos+block_size, corridor.z, obj_staircase_generic, {
				zrotation: 180,
				other_end: other_end,
				dir: stairs_dir,
				cardinal_direction: cardinal.west,
				orientation: cell[corridor_cell_prop.orientation],
				areas: other_end == noone ? [corridor] : other_end.areas
			});
			
			area_add_actor_3d(corridor, xpos, ypos+block_size, corridor.z, obj_wall_generic, {
				zrotation: 270,
				collidable: false,
				sprite_index: wall
			});
			
			area_add_actor_3d(corridor, xpos-block_size, ypos, corridor.z, obj_wall_generic, {
				zrotation: 90,
				collidable: false,
				sprite_index: wall
			});
			
			if (stairs_dir == stairs_directions.down) {
				area_add_actor_3d(corridor, xpos, ypos+block_size, corridor.z+default_block_size, obj_wall_generic, {
					zrotation: 270,
					collidable: false,
					sprite_index: wall
				});
			
				area_add_actor_3d(corridor, xpos-block_size, ypos, corridor.z+default_block_size, obj_wall_generic, {
					zrotation: 90,
					collidable: false,
					sprite_index: wall
				});
			}
		} else
		if (cell[corridor_cell_prop.wall_west] >= 0) {
			area_add_actor_3d(corridor, xpos, ypos+block_size, corridor.z, obj_wall_random_generic, {
				zrotation: 180,
				sprite_index: wall,
				passage: cell[corridor_cell_prop.wall_west] == 1
			});
		}
		
		if (cell[corridor_cell_prop.wall_north] == 2 && !obj_player.has_finished_tasks) {
			var other_end = cell[corridor_cell_prop.other_ends][cardinal.north]
			var stairs_dir = staircase_get_direction(other_end)
			
			area_add_actor_3d(corridor, xpos, ypos, corridor.z, obj_staircase_generic, {
				zrotation: 90,
				other_end: other_end,
				dir: stairs_dir,
				cardinal_direction: cardinal.north,
				orientation: cell[corridor_cell_prop.orientation],
				areas: other_end == noone ? [corridor] : other_end.areas
			});
			
			area_add_actor_3d(corridor, xpos, ypos, corridor.z, obj_wall_generic, {
				zrotation: 180,
				collidable: false,
				sprite_index: wall
			});
			
			area_add_actor_3d(corridor, xpos+block_size, ypos-block_size, corridor.z, obj_wall_generic, {
				zrotation: 0,
				collidable: false,
				sprite_index: wall
			});
			
			
			if (stairs_dir == stairs_directions.down) {
				area_add_actor_3d(corridor, xpos, ypos, corridor.z+default_block_size, obj_wall_generic, {
					zrotation: 180,
					collidable: false,
					sprite_index: wall
				});
			
				area_add_actor_3d(corridor, xpos+block_size, ypos-block_size, corridor.z+default_block_size, obj_wall_generic, {
					zrotation: 0,
					collidable: false,
					sprite_index: wall
				});
			}
		} else
		if (cell[corridor_cell_prop.wall_north] >= 0) {
			area_add_actor_3d(corridor, xpos, ypos, corridor.z, obj_wall_random_generic, {
				zrotation: 90,
				sprite_index: wall,
				passage: cell[corridor_cell_prop.wall_north] == 1
			});
		}
		
		if (cell[corridor_cell_prop.wall_south] == 2 && !obj_player.has_finished_tasks) {
			var other_end = cell[corridor_cell_prop.other_ends][cardinal.south]
			var stairs_dir = staircase_get_direction(other_end)
			
			area_add_actor_3d(corridor, xpos+block_size, ypos+block_size, corridor.z, obj_staircase_generic, {
				zrotation: 270,
				other_end: other_end,
				dir: stairs_dir,
				cardinal_direction: cardinal.south,
				orientation: cell[corridor_cell_prop.orientation],
				areas: other_end == noone ? [corridor] : other_end.areas
			});
			
			area_add_actor_3d(corridor, xpos+block_size, ypos+block_size, corridor.z, obj_wall_generic, {
				zrotation: 0,
				collidable: false,
				sprite_index: wall
			});
			
			area_add_actor_3d(corridor, xpos, ypos+block_size*2, corridor.z, obj_wall_generic, {
				zrotation: 180,
				collidable: false,
				sprite_index: wall
			});
			
			if (stairs_dir == stairs_directions.down) {
				area_add_actor_3d(corridor, xpos+block_size, ypos+block_size, corridor.z+default_block_size, obj_wall_generic, {
					zrotation: 0,
					collidable: false,
					sprite_index: wall
				});
			
				area_add_actor_3d(corridor, xpos, ypos+block_size*2, corridor.z+default_block_size, obj_wall_generic, {
					zrotation: 180,
					collidable: false,
					sprite_index: wall
				});
			}
		} else
		if (cell[corridor_cell_prop.wall_south] >= 0) {
			area_add_actor_3d(corridor, xpos+block_size, ypos+block_size, corridor.z, obj_wall_random_generic, {
				zrotation: 270,
				sprite_index: wall,
				passage: cell[corridor_cell_prop.wall_south] == 1
			});
		}
		
		if (cell[corridor_cell_prop.door_east] == 0) {
			array_push(corridor.doors, area_add_actor_3d(corridor, xpos+block_size, ypos+door_passage_side_width, corridor.z, door, {
				zrotation: 0,
				opening_direction: angular.counterclockwise,
				locked: random_event(corridor.prob_door_locked),
				number_side: cardinal.east,
				areas: {
					west: corridor
				}
			}));
		}
		
		if (cell[corridor_cell_prop.door_west] == 0) {
			array_push(corridor.doors, area_add_actor_3d(corridor, xpos, ypos+door_passage_side_width, corridor.z, door, {
				zrotation: 0,
				opening_direction: angular.clockwise,
				locked: random_event(corridor.prob_door_locked),
				number_side: cardinal.west,
				areas: {
					east: corridor
				}
			}));
		}
		
		if (cell[corridor_cell_prop.door_north] == 0) {
			array_push(corridor.doors, area_add_actor_3d(corridor, xpos+door_passage_side_width, ypos, corridor.z, door, {
				zrotation: 90,
				opening_direction: angular.counterclockwise,
				locked: random_event(corridor.prob_door_locked),
				number_side: cardinal.north,
				areas: {
					south: corridor
				}
			}));
		}
		
		if (cell[corridor_cell_prop.door_south] == 0) {
			array_push(corridor.doors, area_add_actor_3d(corridor, xpos+door_passage_side_width, ypos+block_size, corridor.z, door, {
				zrotation: 90,
				opening_direction: angular.clockwise,
				locked: random_event(corridor.prob_door_locked),
				number_side: cardinal.south,
				areas: {
					north: corridor,
				}
			}));
		}
		
		if (cell[corridor_cell_prop.lamp] == 0) {
			area_add_actor_3d(corridor, xpos+block_size*.5, ypos+block_size*.5, corridor.z, obj_lamp_generic, {
				billboard: true,
				sprite_index: lamp
			});
		}
	}
	
	if (cell_end < n_cells) {
		var group = [];
		
		group[sg.walls] = [wall];
		group[sg.doors] = [door];
		group[sg.lamps] = [lamp];
		
		corridor.add_to_building_queue(group, block_size, door_passage_side_width);	
	} else {
		var preferred_number, use_destination
		
		use_destination = obj_player.has_finished_tasks && array_length(corridor.doors) > 1
		
		if (use_destination) {
			preferred_number = obj_game_control.door_number_destination
		} else {
			preferred_number = obj_player.get_tasked_door()
		}

		if (!is_undefined(preferred_number)) {
			var index = array_find(obj_game_control.door_numbers_avaliable, preferred_number)
		
			if (index != -1 && array_length(corridor.doors) > 0) {
				var door_sel = array_choose(corridor.doors)
				
				door_change_number_index(door_sel, index)
			}
			
			if (use_destination) {
				instance_activate_object(obj_door_random_generic)
			
				with (obj_door_random_generic) {
					locked =	door_number != obj_game_control.door_number_destination &&
								door_number != obj_player.last_door_passed.door_number
				}	
			}
		}
		
		
	}
}