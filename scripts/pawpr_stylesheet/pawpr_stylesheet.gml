function pawpr_stylesheet(styles) {
	var class_names, n_classes, stylesheet;
	
	class_names = variable_struct_get_names(styles);
	n_classes = array_length(class_names);
	stylesheet = {};

	for (var i = 0; i < n_classes; i++) {
		var name, value;
		
		name = class_names[i];
		value = variable_struct_get(styles, name);
		
		variable_struct_set(stylesheet, name, pawpr_class(value));
	}
	
	return stylesheet;
}