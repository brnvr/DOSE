function cursor_center() {
	global.cursor_x = game_view_center_x;
	global.cursor_y = game_view_center_y;
	
	window_mouse_set(global.cursor_x, global.cursor_y);
}