function color_get_array(color) {
	var r, g, b;
	
	r = color_get_red(color);
	g = color_get_green(color);
	b = color_get_blue(color);
	
	return [r, g, b];
}