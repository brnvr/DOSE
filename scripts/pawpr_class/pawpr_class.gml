function pawpr_class(struct={}, n_slots=64) {
	var class = pawpr_buffer(n_slots);
	
	var property_names = variable_struct_get_names(struct);
	var n_properties = array_length(property_names);
	
	for (var i = 0; i < n_properties; i++) {
		var property_name = property_names[i];
		var property_index = pawpr_style_get_index(property_name);
		
		if (property_index != -1) {
			var property_value = variable_struct_get(struct, property_name);	
			class[property_index] = property_value;
		}
		
	}
	
	var selectors = pawpr_selectors(struct);
	if (!is_undefined(selectors[0])) class[pawpr.selectors] = selectors;

	return class;
}