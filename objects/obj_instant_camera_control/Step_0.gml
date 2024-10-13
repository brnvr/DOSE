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
		
		var sprite = sprite_create_from_screen(
			game_view_center_x-instant_photograph_width*.5,
			game_view_center_y-instant_photograph_height*.5,
			instant_photograph_width,
			instant_photograph_height,
			instant_photograph_width*.5,
			instant_photograph_height*.5)
		
		sprite_save(sprite, 0, $"photographs/{global.photo_count++}.png")
		sprite_delete(sprite)
		audio_play_sound(snd_shutter, 10, false)
		
		if (photographs == noone) {
			var obj_photographs = instance_create_layer(0, 0, "Abstract", obj_instant_photographs)
			
			photographs = obj_player.inventory_add_item(obj_photographs, false)
			
			instance_destroy(obj_photographs)
		} else {
			photographs.number++	
		}
		
		var n_shots = obj_player.inventory_remove_item(obj_instant_camera, camera.number == 1)
		
		if (n_shots <= 0) {
			time_source_start(ts_stow_camera)
		}
	})
}	