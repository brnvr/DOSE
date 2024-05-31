function draw_text_shadow_ext_transformed(xx, yy, str, sep, w, xscale, yscale, shadow_color, shadow_alpha, distance_x, distance_y) {
	var previous_color, previous_alpha;
	
	previous_color = draw_get_color();
	previous_alpha = draw_get_alpha();
	
	
	draw_set_color(shadow_color);
	draw_set_alpha(shadow_alpha);
	
	draw_text_ext_transformed(xx+distance_x, yy+distance_y, str, sep, w, xscale, yscale, 0);
	
	draw_set_color(previous_color);
	draw_set_alpha(previous_alpha);
	
	draw_text_ext_transformed(xx, yy, str, sep, w, xscale, yscale, 0);
}