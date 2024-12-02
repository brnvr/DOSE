audio_group_load(ag_music)
audio_group_load(ag_ui_effects)
audio_group_load(ag_game_effects)
instance_create_layer(0, 0, "Abstract", obj_def);
instance_create_layer(0, 0, "Abstract", obj_settings);
instance_create_layer(0, 0, "Abstract", obj_mesh_repo);
instance_create_layer(0, 0, "Abstract", obj_control);
instance_create_layer(0, 0, "Abstract", obj_hud);
room_goto(room_game)