function pawpr_selectors(selectors_struct={}, n_slots=16) {
	return pawpr_map(selectors_struct, n_slots, pawpr_selector_get_index, pawpr_class);
}