function application_resize(aspect) {
	var fullscreen;
	
	fullscreen = window_get_fullscreen();

	/*if (fullscreen) {
		screen_height = display_get_width()/3;	
	} else {
		screen_height = 360;
	}*/

	screen_height = 360;
	screen_width = screen_height*aspect;
	
	surface_resize(application_surface, screen_width, screen_height);

	cursor_center();

}