is_disappearing = false
is_transforming = false
espeak_buffer = espeak_buffer_create()
sound_3d = instance_create_layer(x, y, "Abstract", obj_sound_3d, { z: z-height })

if (height == -1) {
	var center_x = sprite_get_width(sprite_index)*.5
	
	height = sprite_get_height(sprite_index)-sprite_get_first_opaque_pixel_in_column(sprite_index, 0, center_x)
}

if (array_length(bbox_list) == 0) {
	bbox_list = [bbox_create(-32/xscale, -32/yscale, z-height/zscale, 32/xscale, 32/yscale, z)]
}

if (take_chance(prob_event)) {
	event = array_choose(global.npc_events)
}

array_push(interactions_list, [obj_currant_syrup, function() {
	obj_player.inventory_remove_item(obj_currant_syrup)
}])

event_inherited()