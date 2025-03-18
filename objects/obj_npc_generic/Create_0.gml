options_menu = []
is_disappearing = false
is_transforming = false
espeak_buffer = espeak_buffer_create()
bbox_list = bbox_list ?? []

if (height == -1) {
	var center_x = sprite_get_width(sprite_index)*.5
	
	height = sprite_get_height(sprite_index)-sprite_get_first_opaque_pixel_in_column(sprite_index, 0, center_x)
}

if (array_length(bbox_list) == 0) {
	bbox_list = [bbox_create(-32/xscale, -32/yscale, z-height/zscale, 32/xscale, 32/yscale, z)]
}

if (random_event(prob_event)) {
	var npc_events_in_realm = events_in_realm(global.npc_events, global.current_realm)
	
	event = array_choose(npc_events_in_realm)
}

interactable_set_interaction(id, obj_currant_syrup, function() {
	inventory_remove_item(obj_currant_syrup)
})

event_inherited()