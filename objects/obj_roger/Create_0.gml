interactable_set_interaction(id, obj_vhs_tape, function() {
	inventory_remove_item(obj_vhs_tape)
	obj_hud.show_notification("VHS tape given to Roger")
})

event_inherited()