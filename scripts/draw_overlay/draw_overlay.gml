function draw_overlay(color=c_black, alpha=.35) {
	var previous_color, previous_alpha;
	
	previous_color = draw_get_color();
	previous_alpha = draw_get_alpha();
	
	draw_set_color(color);
	draw_set_alpha(alpha);
	draw_rectangle(0, 0, screen_width, screen_height, false);
	draw_set_color(previous_color);
	draw_set_alpha(previous_alpha);
}