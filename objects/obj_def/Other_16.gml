/// @description Sets events

area_events[ev_area.blinking] = function(area) {
	var blinking = instance_create_layer(0, 0, "Abstract", obj_light_blinking_overlay, {
		parent_area: area
	})
	
	area_append_instance(area, blinking)
	
	return false	
}

corridor_events[ev_corridor.spider] = function(corridor, block_size, create_actors) {
	create_actors(corridor, block_size, 1, array_create_copy(corridor.cells_used), [obj_spider], false)
		
	return true
}

npc_events[ev_npc.disappear_on_distance] = function(npc, block_size) {
	if (point_distance(npc.x, npc.y, obj_player.x, obj_player.y) < block_size*2) {
		instance_destroy(npc)	
	}
}

npc_events[ev_npc.transform_into_waiter] = function(npc, block_size) {
	if (!instance_exists(obj_waiter)) {
		if (point_distance(npc.x, npc.y, obj_player.x, obj_player.y) < block_size*2) {
			var position_2d = position_3d_get_projected(npc.x, npc.y, npc.z)

			if (is_undefined(position_2d)) {
				return	
			}
		
			if (position_2d[0] > game_view_x &&
				position_2d[0] < game_view_x + game_view_width &&
				position_2d[1] > game_view_y &&
				position_2d[1] < game_view_y + game_view_height) {
			
				npc_transform_into_another(npc, "obj_waiter", false)
				game_set_music_track(snd_horror_vacui_rainyskip)
			}	
		}
	}
}