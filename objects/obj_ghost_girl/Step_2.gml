

if (!catched_player && !disappearing) {
	var dist_to_player = point_distance(x, y, obj_player.x, obj_player.y)
	
	if (dist_to_player < default_block_size * 4) {
		if (time_source_get_state(ts_disappear) != time_source_state_active) {
			time_source_reconfigure(ts_disappear, irandom_range(1, 15), time_source_units_seconds, disappear)
			time_source_start(ts_disappear)
		}
	}
	
	if (dist_to_player <  default_block_size/2) {
		catch_player()
	} else {
		alpha = 1 - point_distance(x, y, obj_player.x, obj_player.y) / 500

		move_towards_point(obj_player.x, obj_player.y, 3)	
	}	
}

if (disappearing) {
	alpha -= 0.01
	
	if (alpha < 0) {
		instance_destroy()	
	}
}
	
event_inherited()

