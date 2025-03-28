current_area = obj_game_control.current_area
image_speed = 0.25
has_teleported = false
is_moving = false
is_moving_to_door = false
use_pathfinding = false
process_events = false
door_destination = noone
coords_destination = undefined
path = undefined
dialogue = "You don't belong here"
move_speed = 0

ts_set_image = time_source_create(time_source_global, 15, time_source_units_frames, function() {
	image_index = random(sprite_get_number(sprite_index))
}, [], -1)

ts_speak = time_source_create(time_source_global, 181, time_source_units_frames, function() {
	npc_speak(id, false)
}, [], -1)

ts_send_to_otherside = time_source_create(time_source_global, 35, time_source_units_frames, function() {
	obj_game_control.goto_otherside()

	cursor_center()
	cursor_pause_sync(1)
	
	obj_player.can_interact = true
	obj_player.can_move = true
	obj_player.can_look = true
	
	area_destroy_instance(obj_game_control.current_area, id)
})

ts_move_to_door = time_source_create(time_source_global, 1, time_source_units_frames, function() {})

ts_close_door = time_source_create(time_source_global, 1, time_source_units_frames, function() {})

ts_process_events = time_source_create(time_source_global, 31, time_source_units_frames, function() {
	process_events = true
}, [], -1)

reach_door = function(door) {
	is_moving_to_door = false
	
	if (obj_game_control.current_area == current_area) {
		return
	}
	
	var distance = 128
	var center = wall_passage_width/2
	
	door.is_open = true
	door.being_used = true
	door.opening_direction = angular_opposite(door.opening_direction)
	
	current_area = obj_game_control.current_area
	
	switch (door.orientation) {
		case alignment.vertical:
			y = door.y+center
			
			if (obj_player.x < door.x) {
				coords_destination = [door.x-distance, y]
				x = door.x+distance
			} else {
				coords_destination = [door.x+distance, y]
				x = door.x-distance
			}
				
			break
		
		case alignment.horizontal:
			x = door.x+center
			
			if (obj_player.y < door.y) {
				coords_destination = [x, door.y-distance]
				y = door.y+distance	
			} else {
				coords_destination = [x, door.y+distance]
				y = door.y-distance	
			}
		
			break
	}
	
	time_source_reconfigure(ts_close_door, 2, time_source_units_seconds, function(door) {
		door.being_used = false
		door.is_open = false
		door.opening_direction = angular_opposite(door.opening_direction)
	}, [door])
	
	time_source_start(ts_close_door)
	
	update_following_method()
}

catch_player = function() {
	if (obj_player.is_moving_auto) {
		return	
	}
	
	if (door_destination != noone) {
		door_destination.is_open = false	
	}
	
	obj_player.can_interact = false
	obj_player.can_look = false
	obj_player.can_move = false
	obj_player.camera.pitch = 0
	obj_game_control.tracking_error_variation_factor = 800
	catched_player = true
	
	time_source_start(ts_send_to_otherside)
	
	auto_depth = false
	depth = obj_hud.depth + 10
}

move_to_door = function(door) {
	is_moving_to_door = true
	
	var distance_to_door = point_distance(x, y, door.x, door.y)
	var time_to_reach_door = distance_to_door/(move_speed*2)
	
	time_source_stop(ts_move_to_door)
	
	time_source_reconfigure(ts_move_to_door, floor(time_to_reach_door), time_source_units_frames, function(args) {
		reach_door(args)
	}, [door])
	
	time_source_start(ts_move_to_door)
}

update_following_method = function() {
	if (object_is_ancestor(current_area.object_index, obj_path_area)) {
		use_pathfinding = true
		current_area.begin_pathfinding()
		path = sp_path_create(current_area.sp_grid)
		
		return
	}	
	
	use_pathfinding = false
}

update_following_method()
time_source_start(ts_set_image)
event_inherited()

