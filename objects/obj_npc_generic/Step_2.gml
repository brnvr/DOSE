if (is_disappearing) {
	if (alpha > 0) {
		alpha -= 0.03;	
	} else {
		area_destroy_instance(obj_control.current_area, id);	
	}
}

if (!is_undefined(event)) {
	event(id, default_block_size)	
}

event_inherited();