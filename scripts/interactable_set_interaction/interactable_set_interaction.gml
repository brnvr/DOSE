function interactable_set_interaction(interactable, obj, on_interact) {
	var index = array_find(interactable.interactions_list, obj)
	
	if (index == -1) {
		array_push(interactable.interactions_list, [obj, on_interact])
		
		return
	}
	
	interactable.interactions_list[index] = on_interact
}