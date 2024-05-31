function game_unpause() {
	obj_control.paused = false;
	instance_destroy(obj_pause_screen);
	instance_activate_all();
	cursor_center();
	cursor_pause_sync(1);
	
	cursor_set_sprite(obj_control.cursor_previous);
}