function pawpr_element_get_width_default(element, element_width_func) {
	var padding_left, padding_right, padding, min_width;
	
	min_width = pawpr_element_get_style(element, pawpr.min_width, 0);
	padding = pawpr_element_get_style(element, pawpr.padding, 0);
	padding_left = pawpr_element_get_style(element, pawpr.padding_left, padding);
	padding_right = pawpr_element_get_style(element, pawpr.padding_right, padding);
	
	return max(padding_left+element_width_func(element)+padding_right, min_width);
}