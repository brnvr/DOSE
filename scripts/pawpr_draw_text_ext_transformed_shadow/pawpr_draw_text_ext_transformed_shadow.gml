function pawpr_draw_text_ext_transformed_shadow(x, y, str, sep, w, xscale, yscale, angle, shadow_color, shadow_alpha, shadow_xdist, shadow_ydist) {
	var color_previous, alpha_previous;
	
	color_previous = draw_get_color();
	alpha_previous = draw_get_alpha();
	
	if (shadow_alpha > 0) {
		draw_set_color(shadow_color);
		draw_set_alpha(shadow_alpha*alpha_previous);
		draw_text_ext_transformed(x+shadow_xdist, y+shadow_ydist, str, sep, w, xscale, yscale, angle);
	}
	
	draw_set_color(color_previous);
	draw_set_alpha(alpha_previous);
	
	if (alpha_previous > 0) draw_text_ext_transformed(x, y, str, sep, w, xscale, yscale, angle);
}