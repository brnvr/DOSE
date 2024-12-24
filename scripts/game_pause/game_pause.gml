function game_pause() {
	var screen = sprite_create_from_screen();
	
	with (obj_control) {
		paused = true;
		cursor_previous = obj_cursor.sprite_index;
		instance_deactivate_all(true);
	}
	
	var ctx = {background: screen}
	
	instance_create_depth(0, 0, 0, obj_pause_screen, ctx);
	instance_activate_object(obj_cursor);
	instance_activate_object(obj_settings);
	instance_activate_object(obj_init);
	
	cursor_set_sprite(spr_cursor_arrow);
}