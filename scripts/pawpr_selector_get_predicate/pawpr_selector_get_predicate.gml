function pawpr_selector_get_predicate(selector) {
	switch (selector) {
		case pawpr_sel.hover:
			return function(element) {
				return element[pawpr_attr.is_mouse_over];	
			}
	}
}