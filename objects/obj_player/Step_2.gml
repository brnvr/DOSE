update_camera_position()

if (can_move && !can_interact) {
	cursor_set_sprite(noone)
}

if (is_moving_on_staircase) {
	is_moving = true
}	

if (is_moving) {
	if (!audio_is_playing(snd_footsteps)) {
		audio_play_sound(snd_footsteps, false, true)	
	}
} else {
	audio_stop_sound(snd_footsteps)	
}

event_inherited()