obj_hud.caption = ""
subject_framed = noone

object_apply(obj_camera_subject_generic, function(subject) {
	var dist = point_distance(obj_player.x, obj_player.y, subject.x, subject.y)
	
	subject.is_framed = false
	
	if (interactable_is_in_view(subject, 230, 120, 230, 120)) {
		if (dist < 500) {
			obj_hud.caption = "Too close from the subject"
			obj_hud.caption_set_blinking(true)
		} else if (dist > 950) {
			obj_hud.caption = "Too far from the subject"
			obj_hud.caption_set_blinking(true)
		} else {
			obj_hud.caption = "Perfect!"
			obj_hud.caption_set_blinking(false)
			subject.is_framed = true
			subject_framed = subject
		}
	}
})

if (is_shooting) {
	if (shutter_dir == 0) {
		shutter_yoffset -= 80
		
		if (shutter_yoffset <= 0) {
			shutter_yoffset = 0
			shutter_dir = -1
			time_source_start(ts_open_shutter)
		}
	} else if (shutter_dir == 1) {
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
			
			photographs = inventory_add_item(obj_photographs, false)
			
			instance_destroy(obj_photographs)
		} else {
			photographs.number++	
		}
		
		if (subject_framed != noone) {
			photograph_subject()
		}
		
		var n_shots = inventory_remove_item(obj_instant_camera, camera.number == 1)
		
		if (n_shots <= 0) {
			time_source_start(ts_stow_camera)
		}
	})
}
