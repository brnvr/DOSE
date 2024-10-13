function pawpr_update(ui) {
	var n_elements = array_length(ui[pawpr_attr.elements]);

	var mouse_x_new = pawpr_mouse_x(ui);
	var mouse_y_new = pawpr_mouse_y(ui);

	var has_mouse_moved = (mouse_x_new != ui[pawpr_attr.mouse_x] || mouse_y_new != ui[pawpr_attr.mouse_y]);
	ui[pawpr_attr.has_mouse_moved] = has_mouse_moved;
	
	ui[pawpr_attr.mouse_x] = mouse_x_new;
	ui[pawpr_attr.mouse_y] = mouse_y_new;
	
	if (has_mouse_moved) ui[pawpr_attr.is_mouse_over] = pawpr_is_mouse_over(ui);
	
	for (var i = 0; i < n_elements; i++) {
		var element = ui[pawpr_attr.elements][i];
		var element_n_events = array_length(element[pawpr_attr.events]);
		element[pawpr_attr.is_mouse_entering] = false;
		element[pawpr_attr.is_mouse_leaving] = false;
		
		if (has_mouse_moved) {
			var is_mouse_over = pawpr_is_mouse_over(element);
			
			if (is_mouse_over) {
				if (!element[pawpr_attr.is_mouse_over]) {
					element[pawpr_attr.is_mouse_entering] = true;	
				}
			} else {
				if (element[pawpr_attr.is_mouse_over]) {
					element[pawpr_attr.is_mouse_leaving] = true;	
				}
			}
			
			element[pawpr_attr.is_mouse_over] = is_mouse_over;
		}
		
		for (var j = 0; j < element_n_events; j++) {
			var event_current = element[pawpr_attr.events][j];
			if (is_undefined(event_current)) break;
			
			var event_current_trigger = pawpr_event_get_trigger(event_current[pawpr_dict.key]);
			
			if (event_current_trigger(element)) {
				event_current[pawpr_dict.value](element[pawpr_attr.args], element);	
			}
		}
	}
}