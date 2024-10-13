function pawpr_element_remove_selector(element, selector_name, inherit=false) {
	element[pawpr_attr.style][pawpr.selectors][pawpr_selector_get_index(selector_name)] = undefined;
	
	if (inherit && element[pawpr_attr.type] == "container") {
		var n_children = array_length(element[pawpr_attr.content]);
		
		for (var i = 0; i < n_children; i++) {
			var child = element[pawpr_attr.content][i];
			
			pawpr_element_remove_selector(child, selector_name, true);
		}
	}
}