function door_random_on_interact(door) {
	with (door) {
		static resolve_task = function() {
			var resolve_task = true
		
			if (!is_undefined(resolve_task)) {
				obj_player.resolve_task(task_types.go_back_one_room, id)	
			}
		
			if (revert_task) {
				if (obj_control.current_area != revert_task_opposite_area) {
					obj_player.revert_task(task_types.go_back_one_room, id)
				}	
			}	
		}
	
		static player_enter = function(door, player_pass_through) {
			door.is_open = !door.is_open
			door.has_been_opened = true
			obj_player.last_door_passed = door
			obj_player.door_passing = door
		
			if (door.player_pass_through_auto) {
				player_pass_through(door)
			}	
		}
	
		static create_area = function() {
			var current_area, dest_area, dir

			switch (orientation) {
				case alignment.vertical:
					if (areas[cardinal.west] != noone) {
						current_area = areas[cardinal.west]
						dest_area = areas[cardinal.east]
						dir = cardinal.east	
					} else {
						current_area = areas[cardinal.east]
						dest_area = areas[cardinal.west]
						dir = cardinal.west
					}
		
					break
		
				case alignment.horizontal:
					if (areas[cardinal.north] != noone) {
						current_area = areas[cardinal.north]
						dest_area = areas[cardinal.south]	
						dir = cardinal.south
					} else {
						current_area = areas[cardinal.south]
						dest_area = areas[cardinal.north]
						dir = cardinal.north
					}
		
					break
			}

			if (dest_area == noone) {
				if (current_area.object_index == obj_corridor) {
					dest_area = door_make_room(id, dir)
				}
	
				if (current_area.object_index == obj_room) {
					var prob_room
		
					prob_room = .33
		
					if (take_chance(prob_room)) {
						dest_area = door_make_room(id, dir)
					} else {
						dest_area = door_make_corridor(id, dir)
					}
				}
	
				if (current_area.object_index == obj_custom_area) {
					dest_area = door_make_corridor(id, dir)	
				}
	
				array_push(dest_area.neighbors, current_area)
				array_push(current_area.neighbors, dest_area)
				array_push(dest_area.instances, id)
	
				areas_destroy_distance(current_area, 1)
			}	
		}
		
		static set_current_area = function() {
			var current_area

			current_area = obj_control.current_area
			obj_player.door_passing = id

			if (is_open) {
				switch (orientation) {
					case alignment.vertical:
						if (current_area == areas[cardinal.west]) {
							if (obj_player.x < x) {
								parent_area = areas[cardinal.east]
							}
						} else {
							if (obj_player.x > x) {
								parent_area = areas[cardinal.west]
							}
						}
		
						break
	
					case alignment.horizontal:
						if (current_area == areas[cardinal.north]) {
							if (obj_player.y < y) {
								parent_area = areas[cardinal.south]
							}
						} else {
							if (obj_player.y > y) {
								parent_area = areas[cardinal.north]
							}
						}
		
						break
				}
			} else {
				switch (orientation) {
					case alignment.vertical:
						if (current_area == areas[cardinal.west]) {
							if (obj_player.x > x) {
								parent_area = areas[cardinal.east]
							}
						} else {
							if (obj_player.x < x) {
								parent_area = areas[cardinal.west]
							}
						}
		
						break
	
					case alignment.horizontal:
						if (current_area == areas[cardinal.north]) {
							if (obj_player.y > y) {
								parent_area = areas[cardinal.south]	
							}
						} else {
							if (obj_player.y < y) {
								parent_area = areas[cardinal.north]
							}
						}
		
						break
				}
			}	
		
			obj_control.current_area = parent_area
		}
	
		static player_pass_through = function(door) {
			var center, distance

			center = bbox_get_center(door.bbox_list[0], door.transformation_matrix)
			distance = default_block_size/2

			switch (door.orientation) {
				case alignment.vertical:
					if (obj_player.x > door.x) {
						obj_player.pass_through_door(door.x-distance, center[1], door)
					} else {
						obj_player.pass_through_door(door.x+distance, center[1], door)
					}
		
					break
		
				case alignment.horizontal:
					if (obj_player.y > door.y) {
						obj_player.pass_through_door(center[0], door.y-distance, door)
					
					} else {
						obj_player.pass_through_door(center[0], door.y+distance, door)
					
					}
		
					break
			}	
		}
	
		if (locked) {
			obj_hud.show_caption("Locked.", true)	
		} else {
			if (obj_control.current_area.object_index == obj_custom_area) {
				var area = obj_control.current_area
			
				if (area.other_end_area >= 0) {
					var invert_dir = area.other_end_direction == cardinal.north || area.other_end_direction == cardinal.west
				
					player_move_to_door(area.main_door, area.other_end_door, invert_dir)
				
					obj_control.current_area = area.other_end_area
					area.other_end_door.opening_direction = !area.other_end_door.opening_direction
				
					player_enter(area.other_end_door, player_pass_through)
				
					area.other_end_door.cullmode = cull_noculling
					area.other_end_door.vbuff_list[1] = noone
				
					return		
				}
			}
			
			if (door_number != -1) {
				var custom_area = global.custom_areas_door_numbers[door_number]
				
				if (custom_area != -1) {
					var door_area = custom_area.main_door
					
					if (door_area.mirrored) {
						door_mirror(door_area)
					}
					
					player_move_to_custom_area(id, custom_area)
			
					custom_area.other_end_area = obj_control.current_area
					custom_area.other_end_door = id
					obj_control.current_area = custom_area
					
					player_enter(door_area, player_pass_through)
			
					return
				}
			}
			
			resolve_task()
			player_enter(id, player_pass_through)
			create_area()
			set_current_area()
		}	
	}
}