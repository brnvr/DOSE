function pawpr_element_has_event(element, event_name) {
	var event_index, n_events;
	
	event_index = pawpr_event_get_index(event_name, true);
	n_events = array_length(element[pawpr_attr.events]);
	
	for (var i = 0; i < n_events; i++) {
		if (is_undefined(element[pawpr_attr.events][i])) break;
		
		if (element[pawpr_attr.events][i][pawpr_dict.key] == event_index) {
			return true;	
		}
	}
	
	return false;
}