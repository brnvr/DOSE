light_direction = [.71, .95, 3.7]
light_hue = [1, 1, 1]
paused = false
cursor_previous = -1
door_numbers_passed = []
door_numbers_avaliable = []
door_number_destination = 319
current_area = noone
current_realm = realms.thisside
current_floor = 0
music_track = noone
music_track_previous = noone
ts_stop_music_track = time_source_create(time_source_global, 1, time_source_units_frames, do_nothing)
tracking_error_alpha = 0.2
tracking_error_distance = 0.1
depth = -89
fog_start = 0
fog_end = 1300
display_debug_overlay = false
vfx_filters = []
afx_filters = []
vfx_resetting_filter_indexes = []
afx_resetting_filter_indexes = []
audio_listener_orientation_offset = 0

audio_bus_main.effects[AudioEffectType.Reverb1] = audio_effect_create(AudioEffectType.Reverb1, { mix: 0 })
audio_bus_main.effects[AudioEffectType.LPF2] = audio_effect_create(AudioEffectType.LPF2, { cutoff: 19845 })

interp = new TimedInterpolator(20, 5000, 20)

goto_otherside = function(remap=true, set_music=true) {
	var darker_color = make_color_rgb(33, 21, 21)
	
	saturation = 0.5
	tracking_error_variation_factor = 4
	current_realm = realms.otherside
	fog_start = 0
	fog_end = 900
	fog_color = darker_color
	background_set_color(darker_color)
	obj_fog_overlay.visible = true
	seed_group = global.seed_groups[realms.otherside]
	
	if (remap) {
		area_remap(current_area, seed_group)
		areas_destroy_distance(current_area, 0)
		instance_destroy(obj_npc_generic)	
	}
	
	if (obj_hud.eyes != noone) {
		instance_destroy(obj_hud.eyes)
		obj_hud.eyes = noone
	}
	
	obj_hud.display_fog = true
	obj_hud.skull = instance_create_layer(593, 276, "GUI", obj_skull)
	
	if (set_music) {
		var next_song = array_choose(global.seed_groups[realms.otherside][sg.music])
	
		game_set_music_track(next_song)	
	}
}

goto_thisside = function(remap=false, set_music=true) {
	var darker_color = c_black
	
	saturation = 0.55
	tracking_error_variation_factor = 1
	current_realm = realms.thisside
	fog_start = 1000
	fog_end = 2000
	fog_color = darker_color
	background_set_color(darker_color)
	obj_fog_overlay.visible = false
	seed_group = global.seed_groups[realms.thisside]
	
	if (remap) {
		area_remap(current_area, seed_group)
		areas_destroy_distance(current_area, 0)
	}
	
	if (obj_hud.skull != noone) {
		instance_destroy(obj_hud.skull)	
		obj_hud.skull = noone
	}
	
	obj_hud.display_fog = false
	obj_hud.eyes = instance_create_layer(593, 260, "GUI", obj_eyes)
	
	if (set_music) {
		var next_song = array_choose(global.seed_groups[realms.thisside][sg.music])
	
		game_set_music_track(next_song)	
	}
}

randomize()
gpu_set_ztestenable(true)
gpu_set_zwriteenable(true)
gpu_set_alphatestenable(true)
gpu_set_tex_repeat(true)
instance_create_layer(0, 0, "Abstract", obj_clock_control)
instance_create_layer(0, 0, "Abstract", obj_mouse_control)
instance_create_layer(0, 0, "Abstract", obj_espeak_control)
instance_create_layer(0, 0, "Abstract", obj_npc_control)
instance_create_layer(0, 0, "Abstract", obj_event_scheduler)

application_surface_draw_enable(false)
audio_falloff_set_model(audio_falloff_exponent_distance)
application_resize(aspect_ratio)

for (var i = 1; i <= 999; i++) {
	array_push(door_numbers_avaliable, i)
}