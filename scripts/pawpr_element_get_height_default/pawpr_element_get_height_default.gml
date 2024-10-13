function pawpr_element_get_height_default(element, element_height_func) {
	var min_height = pawpr_element_get_style(element, pawpr.min_height, 0);
	var padding = pawpr_element_get_style(element, pawpr.padding, 0);
	var padding_top = pawpr_element_get_style(element, pawpr.padding_left, padding);
	var padding_bottom = pawpr_element_get_style(element, pawpr.padding_right, padding);
	
	return max(padding_top+element_height_func(element)+padding_bottom, min_height);
}