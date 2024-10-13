function pawpr_selector_get_index(selector_name, throw_not_found_exception=true) {
	var pawpr_selector_values = {
		"hover": pawpr_sel.hover	
	}
	
	var value = variable_struct_get(pawpr_selector_values, selector_name);
	
	if (throw_not_found_exception && is_undefined(value)) throw $"Selector not found: {selector_name}";	
	return value;
}