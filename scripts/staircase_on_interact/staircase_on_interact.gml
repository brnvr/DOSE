function staircase_on_interact() {
	obj_player.can_interact = false;
	obj_player.can_look = false;
	obj_player.can_move = false;
	
	var next_song = array_choose(obj_control.seed_group[sg.music]);
	
	game_set_music_track(next_song, 1, 2000);
	cursor_set_sprite(-1);
	
	with (obj_waiter) {
		instance_destroy();	
	}
	
	with (obj_npc_transformation) {
		instance_destroy();
	}
	
	if (revert_hint) {
		var arr_hint = [obj_control.current_floor, 1-dir]
		
		obj_player.revert_hint(hint_types.go_to_another_floor, arr_hint)
	}
	
	obj_control.current_floor += (dir == stairs_directions.up) ? 1 : -1
	
	if (array_length(obj_player.active_hints[hint_types.go_to_another_floor]) > 0) {
		var hint_floor = obj_player.active_hints[hint_types.go_to_another_floor][0][0]
		
		if (abs(obj_control.current_floor - hint_floor) > 2) {
			obj_player.fail_hint(hint_types.go_to_another_floor, hint_floor)
		}
	}
	
	instance_create_layer(0, 0, "Abstract", obj_fade_out, {
		on_completed: method({ staircase: id }, function() {
			static resolve_hint = function(staircase) {
				var hint_resolved = obj_player.resolve_hint(hint_types.go_to_another_floor, obj_control.current_floor)
				
				show_debug_message("asdaksjdkasjd")
				show_debug_message(obj_player.active_hints)
					
				if (!is_undefined(hint_resolved)) {
					staircase.other_end.revert_hint = true
				}	
			}
			
			instance_activate_object(obj_area);
			
			if (staircase.other_end != noone) {
				if (!instance_exists(staircase.areas[0])) {
					array_delete(staircase.areas, 0, 1)
					staircase.other_end = noone;
				}
				
				if (array_length(staircase.areas) > 1 && !instance_exists(staircase.areas[1])) {
					array_delete(staircase.areas, 1, 1)
					staircase.other_end = noone;
				}
			}
			
			var corridor = passage_get_next_area(staircase, method({ staircase: staircase, resolve_hint: resolve_hint }, function() {
				return actor_3d_create(obj_player.x, obj_player.y, 0, obj_corridor, {
					on_built: method(self, function(corridor) {
						corridor_populate(corridor, obj_control.seed_group, default_block_size)
						resolve_hint(staircase)
					}),
				});
			}))
			
			if (staircase.other_end == noone) {
				var staircase_coords, new_staircase_direction
				
				corridor_generate(corridor)
			
				new_staircase_direction = cardinal_opposite(staircase.cardinal_direction)
				staircase_coords = corridor_get_staircase_random(corridor, new_staircase_direction)
				
				if (is_undefined(staircase_coords)) {
					staircase_coords = corridor_add_staircase_random(corridor, new_staircase_direction)
				}
				
				corridor.grid[# staircase_coords[0], staircase_coords[1]][corridor_cell_prop.other_ends][new_staircase_direction] = staircase
				
				corridor_build(corridor, obj_control.seed_group, default_block_size, wall_passage_width)
				
				obj_player.x = corridor.x + default_block_size*(staircase_coords[0]+.5)
				obj_player.y = corridor.y + default_block_size*(staircase_coords[1]+.5)
			} else {
				var other_end, xoffset, yoffset;
				
				other_end = staircase.other_end;
				
				resolve_hint(staircase)
				
				switch (other_end.cardinal_direction) {
					case cardinal.east:
						yoffset =  default_block_size*.5
						xoffset = -default_block_size*.5
						break
						
					case cardinal.west:
						yoffset =  -default_block_size*.5
						xoffset = default_block_size*.5
						break
						
					case cardinal.north:
						yoffset =  default_block_size*.5
						xoffset = default_block_size*.5
						break
						
					case cardinal.south:
						yoffset =  -default_block_size*.5
						xoffset = -default_block_size*.5
						break
				}
				
				obj_player.x = other_end.x + xoffset
				obj_player.y = other_end.y + yoffset
			}
			
			camera_3d.yaw = staircase.zrotation
			
			obj_control.current_area = corridor
				
			instance_create_layer(0, 0, "Abstract", obj_fade_in, {
				on_completed: function() {
					obj_player.can_interact = true
					obj_player.can_look = true
					obj_player.can_move = true
					cursor_center()
					cursor_pause_sync(1)
				}
			})
		})
	})	
}