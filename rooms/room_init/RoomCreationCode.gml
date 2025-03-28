audio_group_load(ag_music)
audio_group_load(ag_ui_effects)
audio_group_load(ag_game_effects)

ts_goto_game = time_source_create(time_source_global, 1, time_source_units_frames, function() {
	instance_create_layer(0, 0, "Abstract", obj_init)
	instance_create_layer(0, 0, "Abstract", obj_settings)
	instance_create_layer(0, 0, "Abstract", obj_mesh_repo)
	instance_create_layer(0, 0, "Abstract", obj_game_control)
	instance_create_layer(0, 0, "Abstract", obj_hud)
	room_goto(room_game)	
	
	time_source_destroy(ts_goto_game)
})

time_source_start(ts_goto_game)