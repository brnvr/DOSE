function pawpr_style_get_index(property_name, throw_not_found_exception=true) {
	var pawpr_property_values, value;
	
	pawpr_property_values = {
		"padding": pawpr.padding,
	    "padding_left": pawpr.padding_left,
	    "padding_top": pawpr.padding_top,
	    "padding_right": pawpr.padding_right,
	    "padding_bottom": pawpr.padding_bottom,
	    "margin": pawpr.margin,
	    "margin_left": pawpr.margin_left,
	    "margin_top": pawpr.margin_top,
	    "margin_right": pawpr.margin_right,
	    "margin_bottom": pawpr.margin_bottom,
	    "align": pawpr.align,
	    "direction": pawpr.direction,
	    "scale": pawpr.scale,
	    "color": pawpr.color,
	    "alpha": pawpr.alpha,
	    "expansion": pawpr.expansion,
	    "font": pawpr.font,
	    "line_width": pawpr.line_width,
	    "line_separation": pawpr.line_separation,
	    "background_color": pawpr.background_color,
	    "background_alpha": pawpr.background_alpha,
	    "border_radius": pawpr.border_radius,
	    "border_color": pawpr.border_color,
	    "border_alpha": pawpr.border_alpha,
	    "shadow_xdistance": pawpr.shadow_xdistance,
	    "shadow_ydistance": pawpr.shadow_ydistance,
	    "shadow_color": pawpr.shadow_color,
	    "shadow_alpha": pawpr.shadow_alpha,
		"image_speed": pawpr.image_speed,
		"image_index": pawpr.image_index,
		"min_width": pawpr.min_width,
		"min_height": pawpr.min_height,
		"xoffset": pawpr.xoffset,
		"yoffset": pawpr.yoffset
	}
	
	value = variable_struct_get(pawpr_property_values, property_name);
	
	if (is_undefined(value)) {
		if (!is_undefined(pawpr_selector_get_index(property_name, false))) return -1;
		if (throw_not_found_exception) throw $"Property '{property_name}' not found.";	
	}
	
	return value;
}