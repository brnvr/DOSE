function pawpr_element_set_style(element, property_name, value, inherit=false) {
	element[pawpr_attr.style][pawpr_style_get_index(property_name)] = value;
	
	if (inherit && element[pawpr_attr.type] == "container") {
		var n_children;
		
		n_children = array_length(element[pawpr_attr.content]);
		
		for (var i = 0; i < n_children; i++) {
			var child;
			
			child = element[pawpr_attr.content][i];
			
			pawpr_element_set_style(child, property_name, value, true);
		}
	}
}