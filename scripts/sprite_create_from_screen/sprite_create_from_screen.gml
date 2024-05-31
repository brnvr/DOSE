function sprite_create_from_screen(xstt = 0, ystt = 0, width = undefined, height = undefined, xorigin = 0, yorigin = 0) {
	var max_width, max_height;
	
	max_width = surface_get_width(application_surface);
	max_height = surface_get_height(application_surface);
	
	width ??= max_width;
	height ??= max_height;
	
	if (xstt > max_width) throw "xstt can't be larger than the application_width";
	if (ystt > max_height) throw "ystt can't be larger than the the application_height";
	
	return sprite_create_from_surface(application_surface, xstt, ystt, width, height, false, false, xorigin, yorigin);
}