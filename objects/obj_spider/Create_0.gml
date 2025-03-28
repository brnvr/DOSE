area = obj_game_control.current_area
moving_away = false
on_ceiling = choose(true, false)

if (on_ceiling) {
	sprite_index = global.spr_spider_ceiling
	z += default_block_size
}

if (object_is_ancestor(obj_game_control.current_area.object_index, obj_path_area)) {
	obj_game_control.current_area.begin_pathfinding()
	path = sp_path_create(obj_game_control.current_area.sp_grid)
} else {
	path = undefined	
}

ts_restart_attack = time_source_create(time_source_global, irandom_range(25, 50), time_source_units_frames, function() {
	moving_away = false
})

sound_emitter.sound = snd_spider_walking
sound_emitter.loops = true
sound_emitter_3d_play(sound_emitter)

event_inherited()
