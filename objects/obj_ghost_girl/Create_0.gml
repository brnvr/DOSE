alarm[0] = 5
catched_player = false
disappearing = false
tracking_error_variation_factor_previous = 0

ts_disappear = time_source_create(time_source_global, 0, time_source_units_seconds, do_nothing)

ts_catch_player = time_source_create(time_source_global, 0.4, time_source_units_seconds, function() {
	instance_destroy()
	
	with (obj_control) {
		event_user(1)	
	}
	
	obj_control.tracking_error_variation_factor = tracking_error_variation_factor_previous
	
	
	obj_player.can_look = true
	obj_player.can_move = true
	obj_player.can_interact = true
})

disappear = function() {
	if (!catched_player) {
		disappearing = true	
	}
}

catch_player = function() {
	if (obj_player.is_moving_auto) {
		return	
	}
		
	tracking_error_variation_factor_previous = obj_control.tracking_error_variation_factor
	obj_player.can_interact = false
	obj_player.can_look = false
	obj_player.can_move = false
	obj_player.focus = id
	obj_control.tracking_error_variation_factor = 800
	catched_player = true
	
	time_source_start(ts_catch_player)
}

event_inherited()