if (is_shooting) {
	if (shutter_dir == 0) {
		shutter_yoffset -= 80
		
		if (shutter_yoffset <= 0) {
			shutter_yoffset = 0
			shutter_dir = -1
			time_source_start(ts_open_shutter)
		}
	} 
	
	if (shutter_dir == 1) {
		shutter_yoffset += 80
		
		if (shutter_yoffset > MAX_SHUTTER_YOFFSET) {
			shutter_dir = 0
			is_shooting = false
		}
	}
} else {
	mouse_click(mb_left, function() {
		is_shooting = true
		
		var sprite = sprite_create_from_screen(game_view_center_x-100, game_view_center_y-100, 200, 200, 100, 100)
		
		sprite_save(sprite, 0, $"photographs/{photo_count++}.png")
		sprite_delete(sprite)
		audio_play_sound(snd_shutter, 10, false)
		
		if (photographs == noone) {
			var obj_photographs = instance_create_layer(0, 0, "Abstract", obj_instant_photographs)
			
			photographs = obj_player.inventory_add_item(obj_photographs, false)
		} else {
			photographs.number++	
		}
	})
}	