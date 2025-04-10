function pawpr_element_process_style(element, custom_properties_to_bypass=[]) {
	var element_class = element[pawpr_attr.class];
	
	if (is_undefined(element_class) || element_class == "") return;
	
	var element_class_list = string_split(element_class, " ", true);
	var element_n_classes = array_length(element_class_list);
	var properties_to_bypass = array_concat(custom_properties_to_bypass, [pawpr.selectors, pawpr.background_alpha, pawpr.background_color, pawpr.border_radius, pawpr.direction, pawpr.align, pawpr.min_width, pawpr.min_height, pawpr.xoffset, pawpr.yoffset, pawpr.padding, pawpr.padding_bottom, pawpr.padding_top, pawpr.padding_left, pawpr.padding_right, pawpr.margin, pawpr.margin_bottom, pawpr.margin_top, pawpr.margin_left, pawpr.margin_right])
	
	var class_names = variable_struct_get_names(element[pawpr_attr.ui][pawpr_attr.stylesheet]);
	var n_classes = array_length(class_names);

	for (var i = element_n_classes-1; i >= 0; i--) {
		var class_name = element_class_list[i];
		
		for (var j = 0; j < n_classes; j++) {
			if (class_name == class_names[j]) {
				var class = variable_struct_get(element[pawpr_attr.ui][pawpr_attr.stylesheet], class_name);	
				
				pawpr_style_join(element, class);
			}
		}
	}
	
	pawpr_style_join(element, element[pawpr_attr.parent][pawpr_attr.style], properties_to_bypass);
}