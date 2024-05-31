function pawpr_element(params) {
	var element;
	
	if (!variable_struct_exists(params, "content")) throw "Element must have a content.";
	
	element = [];
	
	if (variable_struct_exists(params, "type")) {
		element[pawpr_attr.type] = params.type;	
	} else {
		element[pawpr_attr.type] = "container";
	}
	
	if (element[pawpr_attr.type] == "container") {
		element[pawpr_attr.content] = array_map(params.content, function(val) {
			if (is_struct(val)) {
				return pawpr_element(val);	
			}
			
			if (is_array(val)) {
				return val;	
			}
			
			throw "Invalid element";
		});
	} else {
		element[pawpr_attr.content] = params.content;	
	}

	if (variable_struct_exists(params, "class")) {
		element[pawpr_attr.class] = params.class;
	} else {
		element[pawpr_attr.class] = "";
	}	
	
	if (variable_struct_exists(params, "style")) {
		element[pawpr_attr.style] = pawpr_class(params.style);
	} else {
		element[pawpr_attr.style] = pawpr_class();
	}
	
	element[pawpr_attr.events] = pawpr_events(params);
	
	if (variable_struct_exists(params, "args")) {
		element[pawpr_attr.args] = params.args;
	}
	
	return element;
}