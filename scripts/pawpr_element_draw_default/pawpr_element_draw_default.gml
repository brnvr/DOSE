function pawpr_element_draw_default(element, draw_func) {
	var bounding_rect = pawpr_element_get_bounding_rect(element);
	
	var padding = pawpr_element_get_style(element, pawpr.padding, 0);
	var padding_left = pawpr_element_get_style(element, pawpr.padding_left, padding);
	var padding_top = pawpr_element_get_style(element, pawpr.padding_right, padding);
	var padding_right = pawpr_element_get_style(element, pawpr.padding_right, padding);
	var padding_bottom = pawpr_element_get_style(element, pawpr.padding_bottom, padding);	
	var bg_alpha = pawpr_element_get_style(element, pawpr.background_alpha, 0);
	var border_alpha = pawpr_element_get_style(element, pawpr.border_alpha, 0);
	
	var previous_color = draw_get_color();
	var previous_alpha = draw_get_alpha();

	if (bg_alpha > 0) {
		var bg_color = pawpr_element_get_style(element, pawpr.background_color, c_black);
		var border_radius = pawpr_element_get_style(element, pawpr.border_radius, 0);
		
		draw_set_color(bg_color);
		draw_set_alpha(bg_alpha);
		draw_roundrect_ext(bounding_rect[pawpr_rect.left], bounding_rect[pawpr_rect.top], bounding_rect[pawpr_rect.right], bounding_rect[pawpr_rect.bottom], border_radius, border_radius, false);
		
	}
	
	if (border_alpha > 0) {
		var border_color = pawpr_element_get_style(element, pawpr.border_color, c_white);
		var border_radius = pawpr_element_get_style(element, pawpr.border_radius, 0);
		
		draw_set_color(border_color);
		draw_set_alpha(border_alpha);
		draw_roundrect_ext(bounding_rect[pawpr_rect.left], bounding_rect[pawpr_rect.top], bounding_rect[pawpr_rect.right], bounding_rect[pawpr_rect.bottom], border_radius, border_radius, true);
	}
	
	draw_set_color(previous_color);
	draw_set_alpha(previous_alpha);
	
	draw_func(element, bounding_rect[pawpr_rect.left]+padding_left, bounding_rect[pawpr_rect.top]+padding_top, bounding_rect[pawpr_rect.right]-padding_right, bounding_rect[pawpr_rect.bottom]-padding_bottom);
}