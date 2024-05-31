function pawpr_events(events_struct={}, n_slots=32) {
	return pawpr_map(events_struct, n_slots, pawpr_event_get_index);
}