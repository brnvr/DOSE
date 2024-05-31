function color_get_normalized(color) {
	var r, g, b;
	
	r = color_get_red(color);
	g = color_get_green(color);
	b = color_get_blue(color);
	
	return [r/255, g/255, b/255];
}