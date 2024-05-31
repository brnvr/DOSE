function game_pause() {
	var screen;
	screen = sprite_create_from_screen();
	
	with (obj_control) {
		paused = true;
		cursor_previous = obj_cursor.sprite_index;
		instance_deactivate_all(true);
	}
	
	instance_create_depth(0, 0, 0, obj_pause_screen, {background: screen});
	instance_activate_object(obj_cursor);
	instance_activate_object(obj_settings);
	instance_activate_object(obj_def);
	
	cursor_set_sprite(spr_cursor_arrow);
}