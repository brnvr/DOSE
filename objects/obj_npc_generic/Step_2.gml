if (instance_exists(sound_emitter)) {
	sound_emitter.x = x
	sound_emitter.y = y
	sound_emitter.z = z - height	
}

if (is_disappearing) {
	if (alpha > 0) {
		alpha -= 0.03;	
	} else {
		area_destroy_instance(obj_game_control.current_area, id);	
	}
}

if (!is_undefined(event)) {
	event[1](id, default_block_size)	
}

event_inherited();