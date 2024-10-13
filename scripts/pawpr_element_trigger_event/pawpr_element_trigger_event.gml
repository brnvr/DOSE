function pawpr_element_trigger_event(element, event_name) {
	var event_index = pawpr_event_get_index(event_name)
	var element_n_events = array_length(element[pawpr_attr.events])
	
	for (var i = 0; i < element_n_events; i++) {
		if (is_undefined(element[pawpr_attr.events][i])) {
			throw $"Event {event_name} not defined for element.";
		}
		
		if (element[pawpr_attr.events][pawpr_dict.key] == event_index) {
			element[pawpr_attr.events][pawpr_dict.value](element);
		}
	}
}