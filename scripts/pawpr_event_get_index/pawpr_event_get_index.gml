function pawpr_event_get_index(event_name, throw_not_found_exception=true) {
	var pawpr_event_values = {
		"on_mouse_over": pawpr_ev.mouse_over,
		"on_mouse_out": pawpr_ev.mouse_out,
		"on_mouse_enter": pawpr_ev.mouse_enter,
		"on_mouse_leave": pawpr_ev.mouse_leave,
		"on_mouse_move": pawpr_ev.mouse_move,
		"on_create": pawpr_ev.create,
		"on_update": pawpr_ev.update
	}
	
	var value = variable_struct_get(pawpr_event_values, event_name);
	
	if (throw_not_found_exception && is_undefined(value)) throw $"Event not found: {event_name}";	
	return value;
}