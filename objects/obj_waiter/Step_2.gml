if (obj_control.current_area.object_index == obj_custom_area) {
	instance_destroy()	
} else {
	speed = 0;

	if (obj_player.door_passing != noone) {
		var go_to_random_door;
	
		coords_destination = undefined;
		is_moving_to_door = false;
		time_source_stop(ts_move_to_door);
	
		if (obj_control.current_area != noone) {
			if (array_length(obj_control.current_area.doors) == 0) {
				go_to_random_door = false;
			} else {
				go_to_random_door = random_event(0.2);	
			}
	
			if (go_to_random_door) {
				door_destination = array_choose(obj_control.current_area.doors);
			} else {
				door_destination = obj_player.door_passing;		
			}	
		}
	}

	if (image_index >= 4) {
		if (!has_teleported) {
			move_speed = 70;
			has_teleported = true;
		} else {
			move_speed = 2;	
		}
	} else {
		move_speed = 2;
		has_teleported = false;
	}

	if (!is_moving) {
		is_moving = (obj_player.door_passing == noone || !obj_player.door_passing.is_open) && !is_transforming;
	
		if (is_moving) {
			time_source_start(ts_process_events);
			time_source_start(ts_speak);
		}
	}

	if (process_events) {
		if (is_moving) {
			var radius, targets;
	
			radius = default_block_size/2;
			targets = instance_get_rectangle(x-radius, y-radius, x+radius, y+radius, obj_npc_generic, true);
	
			array_foreach(targets, function(target) {
				target.is_disappearing = true;
			});
		}
	
		process_events = false;
	}

	if (is_moving) {
		if (is_undefined(coords_destination)) {
			if (current_area == obj_control.current_area) {
				if (point_distance(x, y, obj_player.x, obj_player.y) > default_block_size/2) {
					if (use_pathfinding) {
						sp_find_path_instance_loop(path, id, obj_player, 20, 0);
						sp_follow_path(path, move_speed);
					} else {
						move_towards_point(obj_player.x, obj_player.y, move_speed);	
					}
				} else {
					catch_player();
				}	
			} else {
				if (!is_moving_to_door && door_destination != noone) {
					move_to_door(door_destination);
				}
			}
		} else {
			if (point_distance(x, y, coords_destination[0], coords_destination[1]) > move_speed) {
				move_towards_point(coords_destination[0], coords_destination[1], move_speed);
			} else {
				coords_destination = undefined;
			}
		}
	}
}

if (!is_transforming) {
	visible = current_area == obj_control.current_area	
}

event_inherited();