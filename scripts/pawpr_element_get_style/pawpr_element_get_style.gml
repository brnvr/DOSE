function pawpr_element_get_style(element, property, default_value=undefined, use_selectors=true) {
	var value = undefined
	
	if (use_selectors && !is_undefined(element[pawpr_attr.ui])) {
		var selectors = element[pawpr_attr.style][pawpr.selectors];
		
		if (!is_undefined(selectors)) {
			var n_selectors = array_length(selectors);
			
			for (var i = 0; i < n_selectors; i++) {
				if is_undefined(selectors[i]) break;
				var selector_index = selectors[i][pawpr_dict.key];				
				var selector_predicate = pawpr_selector_get_predicate(selector_index);
				
				if (is_undefined(selector_predicate)) throw "Selector not found.";
				
				if (selector_predicate(element)) {
					var selector_style = selectors[i][pawpr_dict.value];
					
					value = selector_style[property];
					
					if (is_undefined(value)) break;
					
					return value;
				}
			}
		}
	}
		
	value = element[pawpr_attr.style][property];
	
	return is_undefined(value) ? default_value : value;
}