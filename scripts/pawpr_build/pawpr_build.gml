function pawpr_build(ui, element=ui) {
	if (is_undefined(element[pawpr_attr.type])) element[pawpr_attr.type] = "container";
	var type_template = variable_struct_get(ui[pawpr_attr.template], element[pawpr_attr.type]);

	if (is_undefined(type_template)) throw "Element type not found in template";
	
	element[pawpr_attr.width] = 0;
	element[pawpr_attr.height] = 0;
	element[pawpr_attr.xoffset] = 0;
	element[pawpr_attr.yoffset] = 0;
	element[pawpr_attr.is_mouse_over] = false;
	element[pawpr_attr.is_mouse_entering] = false;
	element[pawpr_attr.is_mouse_leaving] = false;
	element[pawpr_attr.ui] = ui;

	pawpr_element_process_style(element);
	if (element != ui) array_push(ui[pawpr_attr.elements], element);
	
	if (!pawpr_element_has_event(element, "on_update") && variable_struct_exists(type_template, "on_update")) {
		array_insert(element[pawpr_attr.events], 0, [pawpr_ev.update, type_template.on_update]);
	}
	
	if (!pawpr_element_has_event(element, "on_create") && variable_struct_exists(type_template, "on_create")) {
		array_insert(element[pawpr_attr.events], 0, [pawpr_ev.create, type_template.on_create]);
		type_template.on_create(element);
	}
	
	if (element[pawpr_attr.type] == "container") {
		if (!is_array(element[pawpr_attr.content])) throw "The content of a container element must be an array";
		
		var content_length = array_length(element[pawpr_attr.content]);
		
		for (var i = 0; i < content_length; i++) {
			var element_current = element[pawpr_attr.content][i];
			if (is_undefined(element_current)) break;
			element_current[pawpr_attr.parent] = element;
			element_current[pawpr_attr.previous] = (i == 0) ? undefined : element[pawpr_attr.content][i-1];
			pawpr_build(ui, element_current);
		}
	}
	
	element[pawpr_attr.width] = type_template.get_width(element);
	element[pawpr_attr.height] = type_template.get_height(element);
	
	if (ui == element) {
		ui[pawpr_attr.mouse_x] = pawpr_mouse_x(ui);
		ui[pawpr_attr.mouse_y] = pawpr_mouse_y(ui);
		var buffer_length = array_length(ui[pawpr_attr.elements]);
	
		for (var i = 0; i < buffer_length; i++) {
			var element_current = ui[pawpr_attr.elements][i];
			element_current[pawpr_attr.xoffset] = type_template.get_xoffset(element_current);
			element_current[pawpr_attr.yoffset] = type_template.get_yoffset(element_current);
		}
	}
}