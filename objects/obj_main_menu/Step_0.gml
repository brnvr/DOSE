if (game_starting) {
	var cam_spd = .1

	if (alpha > 0) {
		alpha -= 0.04
		pawpr_element_set_style(ui, "alpha", alpha, true)
		pawpr_element_remove_selector(ui, "hover", true)
	}
	
	if (abs(camera_yaw_start-player_camera.yaw) > cam_spd &&
		abs(camera_pitch_start-player_camera.pitch) > cam_spd) {
			
		player_camera.yaw = smooth_interpolation(player_camera.yaw, camera_yaw_start, cam_spd)
		player_camera.pitch = smooth_interpolation(player_camera.pitch, camera_pitch_start, cam_spd)
	} else {
		obj_player.can_move = true
		obj_player.can_interact = true
		obj_player.can_look = true
		instance_activate_object(obj_eyes)
		cursor_center()
		cursor_pause_sync(2)
		instance_destroy()
	}
} else {
	player_camera.pitch = camera_pitch_start + pitch_wave.y
	player_camera.yaw = camera_yaw_start + yaw_wave.y;
}

pawpr_update(ui)