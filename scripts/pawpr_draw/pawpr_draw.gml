function pawpr_draw(ui) {
	var length;
	
	length = array_length(ui[pawpr_attr.elements]);
	
	for (var i = 0; i < length; i++) {
		var element, type_template;
		
		element = ui[pawpr_attr.elements][i];
	
		if (is_undefined(element[pawpr_attr.type])) throw "Malformed element: missing type";
	
		type_template = variable_struct_get(ui[pawpr_attr.template], element[pawpr_attr.type]);
		if (is_undefined(type_template)) throw "Element type not found in template";
		
		type_template.draw(element);
	}
}