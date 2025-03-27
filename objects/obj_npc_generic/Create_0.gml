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

if (room != room_init && random_event(prob_event)) {
	var npc_events_in_realm = events_in_realm(global.npc_events, obj_control.current_realm)
	
	event = array_choose(npc_events_in_realm)
}

interactable_set_interaction(id, obj_currant_syrup, function() {
	inventory_remove_item(obj_currant_syrup)
})

if (obj_player.has_met_npc(id) || introductory_dialogue == "") {
	display_name = variable_static_get(object_index, "name")
	
	event_user(0)
} else {		
	var name = variable_static_get(object_index, "name")
	
	dialogue = introductory_dialogue
	display_name = name_before_introduction = "" ? name : name_before_introduction
	
	on_finish_talking = method({ npc: id, name }, function() {
		if (instance_exists(npc)) {
			npc.display_name = name
			npc.dialogue = ""
			npc.on_finish_talking = do_nothing
		}
	})	
}

event_inherited()