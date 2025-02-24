if (instance_exists(obj_player)) {
	if (obj_player.focus == id) {
		obj_player.focus = noone	
	}	
}

time_source_destroy(ts_disappear)
time_source_destroy(ts_catch_player)

event_inherited()

