in_use = false
player_can_play = false
key = 0
xflow = 500
auto_playing = false
wrong_key = false
keys_pressed = array_create(10, -1)
interactions_list = interactions_list ?? []
last_key_pressed = -1
score_index = 0;
synth = "piano"
countdown = 0
countdown_scale = 7
synth_sounds = undefined
score_current_note_index = -1
is_player_moving_away = false
timeline_index = tl_start_puzzle_electronic_keyboard
timeline_speed = .02
timeline_running = false

ts_init = time_source_create(time_source_global, 1.3, time_source_units_seconds, function() {
	if (sheet_music == noone) {
		player_can_play = true	
	} else {
		auto_playing = true
		score_current_note_index = -1
		event_user(3)
	}
})

ts_restart = time_source_create(time_source_global, .8, time_source_units_seconds, function() {
	wrong_key = false
	time_source_start(ts_init)	
})

ts_success = time_source_create(time_source_global, 1.73, time_source_units_seconds, function() {
	instance_destroy(sheet_music)
	sheet_music = noone
	event_user(0)
	obj_hud.add_message("melody flawlessly performed")
})

ts_play_score_note = time_source_create(time_source_global, 1, time_source_units_frames, do_nothing)

on_interact = function() {
	obj_cursor.visible = false
	var center = bbox_get_center(bbox_list[0], transformation_matrix)
	var dist = default_block_size/4.5
	var mat = matrix_build(0, 0, 0, 0, 0, zrotation, 1, 1, 1)
	var vertex = matrix_transform_vertex(mat, -dist, 0, 0)
	var xdest = center[0]+vertex[0]
	var ydest = center[1]+vertex[1]
	
	if (abs(angle_difference(obj_player.camera.yaw, zrotation)) > 50) {
		obj_player.x = xdest
		obj_player.y = ydest
	} else {
		obj_player.move_to(xdest, ydest, obj_player.WALK_SPEED*1.25)
	}
	
	if (sheet_music == noone) {
		time_source_start(ts_init)
	} else {
		timeline_running = true
		timeline_position = 0
	}
	
	in_use = true
	xflow = 500
	obj_player.focus = id
	obj_player.lock_move = true
	
	if (obj_control.music_track != noone) {
		audio_group_set_gain(ag_music, 0, 2000)
	}
	
	event_user(1)
}

array_push(interactions_list, [obj_sheet_music_0, function() {
	sheet_music = area_add_actor_3d(obj_control.current_area, x, y, z-36, obj_sheet_music_0, {
		keyboard: id	
	})
	
	with (sheet_music) {
		event_user(0)	
	}
	
	obj_player.inventory_remove_item(obj_sheet_music_0)
}])

event_inherited()

