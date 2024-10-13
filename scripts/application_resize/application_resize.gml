function application_resize(aspect) {
	var fullscreen;
	
	fullscreen = window_get_fullscreen();

	/*if (fullscreen) {
		screen_height = display_get_width()/3;	
	} else {
		screen_height = 360;
	}*/

	global.screen_height = 360;
	global.screen_width = global.screen_height*aspect;
	
	surface_resize(application_surface, global.screen_width, global.screen_height);

	cursor_center();

}