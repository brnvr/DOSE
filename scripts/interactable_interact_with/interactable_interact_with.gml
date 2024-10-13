function interactable_interact_with(interactable, obj_item, def=do_nothing, arg=[]) {
	var interactions_list = interactable.interactions_list

	var interaction_index = array_find_index(interactions_list, method({ obj_item: obj_item }, function(item) {
		return item[0] == obj_item
	}))
	
	if (interaction_index == -1) {
		return def()
	}
	
	return interactions_list[interaction_index][1](interactable, arg)
}