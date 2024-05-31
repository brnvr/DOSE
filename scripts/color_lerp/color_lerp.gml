function color_lerp(src_color, dest_color, value) {
	var src_r, src_g, src_b, dest_r, dest_g, dest_b, r, g ,b;
	
	src_r = color_get_red(src_color);
	src_g = color_get_green(src_color);
	src_b = color_get_blue(src_color);
	
	dest_r = color_get_red(dest_color);
	dest_g = color_get_green(dest_color);
	dest_b = color_get_blue(dest_color);
	
	r = lerp(src_r, dest_r, value);
	g = lerp(src_g, dest_g, value);
	b = lerp(src_b, dest_b, value);
	
	return make_color_rgb(r, g, b);
}