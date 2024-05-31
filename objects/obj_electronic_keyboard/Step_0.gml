if (in_use) {
	obj_player.can_move = false	
	obj_player.can_interact = false
	obj_player.can_look = false
	
	cursor_center()
	
	if (player_can_play) {
		xflow += window_mouse_get_x()-game_view_center_x
		xflow = clamp(xflow, 0, 1000)
		key = floor(xflow / 1000 * 47)
	
		if (key != last_key_pressed) {
			last_key_pressed = -1	
		}
	
		mouse_click(mb_right, function() {
			event_user(0)
		})	
	
		if (mouse_check_button(mb_left)) {
			if (last_key_pressed != key) {
				last_key_pressed = key
				audio_play_sound(synth_sounds[key], 10, false)
			}
		}
		
		if (sheet_music != noone && mouse_check_button_pressed(mb_left)) {
			var session = sheet_music.piano_score[score_index]
			var session_end_reached = ++score_current_note_index+1 == array_length(session)

			var current_note_data = session[score_current_note_index]
				
			if (current_note_data[0] != key) {
				player_can_play = false
				wrong_key = true
				audio_play_sound(snd_puzzle_error, 10, false)
				time_source_start(ts_restart)
			} else {
				if (session_end_reached) {
					if (session_end_reached) {
						score_index++
						player_can_play = false
						
						if (score_index >= array_length(session)) {
							time_source_start(ts_success)	
						} else {
							time_source_start(ts_restart)
						}
					}
				}
			}
		}
	
		if (mouse_check_button_released(mb_left)) {
			last_key_pressed = -1
		}
	}
}

if (player_can_play || auto_playing) {
	keys_pressed[0] = last_key_pressed
}

if (countdown > 0) {
	countdown_scale = smooth_interpolation(countdown_scale, 4)
}

if (is_player_moving_away) {
	obj_player.camera.pitch += 1
}

event_inherited()