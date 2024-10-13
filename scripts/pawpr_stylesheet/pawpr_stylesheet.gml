function pawpr_stylesheet(styles) {
	var class_names = variable_struct_get_names(styles);
	var n_classes = array_length(class_names);
	var stylesheet = {};

	for (var i = 0; i < n_classes; i++) {
		var name = class_names[i];
		var value = variable_struct_get(styles, name);
		
		variable_struct_set(stylesheet, name, pawpr_class(value));
	}
	
	return stylesheet;
}