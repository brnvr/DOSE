function pawpr_element_draw_default(element, draw_func) {
	var bg_alpha, padding, padding_left, padding_top, padding_right, padding_bottom, bounding_rect, border_alpha, previous_color, previous_alpha;
	
	bounding_rect = pawpr_element_get_bounding_rect(element);
	
	padding = pawpr_element_get_style(element, pawpr.padding, 0);
	padding_left = pawpr_element_get_style(element, pawpr.padding_left, padding);
	padding_top = pawpr_element_get_style(element, pawpr.padding_right, padding);
	padding_right = pawpr_element_get_style(element, pawpr.padding_right, padding);
	padding_bottom = pawpr_element_get_style(element, pawpr.padding_bottom, padding);	
	bg_alpha = pawpr_element_get_style(element, pawpr.background_alpha, 0);
	border_alpha = pawpr_element_get_style(element, pawpr.border_alpha, 0);
	
	previous_color = draw_get_color();
	previous_alpha = draw_get_alpha();

	if (bg_alpha > 0) {
		var bg_color, border_radius;
		
		bg_color = pawpr_element_get_style(element, pawpr.background_color, c_black);
		border_radius = pawpr_element_get_style(element, pawpr.border_radius, 0);
		
		draw_set_color(bg_color);
		draw_set_alpha(bg_alpha);
		draw_roundrect_ext(bounding_rect[pawpr_rect.left], bounding_rect[pawpr_rect.top], bounding_rect[pawpr_rect.right], bounding_rect[pawpr_rect.bottom], border_radius, border_radius, false);
		
	}
	
	if (border_alpha > 0) {
		var border_color;
		
		border_color = pawpr_element_get_style(element, pawpr.border_color, c_white);
		
		draw_set_color(border_color);
		draw_set_alpha(border_alpha);
		draw_roundrect_ext(bounding_rect[pawpr_rect.left], bounding_rect[pawpr_rect.top], bounding_rect[pawpr_rect.right], bounding_rect[pawpr_rect.bottom], border_radius, border_radius, true);
	}
	
	draw_set_color(previous_color);
	draw_set_alpha(previous_alpha);
	
	draw_func(element, bounding_rect[pawpr_rect.left]+padding_left, bounding_rect[pawpr_rect.top]+padding_top, bounding_rect[pawpr_rect.right]-padding_right, bounding_rect[pawpr_rect.bottom]-padding_bottom);
}