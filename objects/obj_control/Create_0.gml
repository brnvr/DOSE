light_direction = [.81, 1, 3.7]
light_hue = [1, 1, 1]
shadow_color = color_get_normalized(c_black)
paused = false
cursor_previous = -1
door_numbers_passed = []
door_numbers_avaliable = []
door_number_destination = 319
current_area = noone
current_floor = 0
music_track = -1
music_track_previous = -1
ts_stop_music_track = time_source_create(time_source_global, 0, time_source_units_frames, function() {})
tracking_error_alpha = 0.2
tracking_error_distance = 0.1
depth = -89
fog_start = 0
fog_end = 1300

goto_otherside = function() {
	var darker_color = make_color_rgb(33, 21, 21)
	
	saturation = 0.5
	tracking_error_variation_factor = 4
	global.current_realm = realms.otherside
	fog_start = 0
	fog_end = 1300
	fog_color = darker_color
	shadow_color = darker_color
	background_set_color(darker_color)
	obj_fog_overlay.visible = true
	seed_group = global.seed_groups[realms.otherside]
	area_remap(current_area, seed_group)
	areas_destroy_distance(current_area, 0)
}

goto_thisside = function(remap=false) {
	//var darker_color = make_color_rgb(12, 16, 11)
	var darker_color = make_color_rgb(3, 5, 2)
	
	tracking_error_variation_factor = 1
	saturation = 0.75
	global.current_realm = realms.thisside
	fog_start = 1000
	fog_end = 2000
	fog_color = darker_color
	shadow_color = darker_color
	background_set_color(darker_color)
	obj_fog_overlay.visible = false
	seed_group = global.seed_groups[realms.thisside]
	
	if (remap) {
		area_remap(current_area, seed_group)
		areas_destroy_distance(current_area, 0)
	}
}

randomize()
gpu_set_ztestenable(true)
gpu_set_zwriteenable(true)
gpu_set_alphatestenable(true)
gpu_set_tex_repeat(true)
instance_create_layer(0, 0, "Abstract", obj_wallclock_control)
instance_create_layer(0, 0, "Abstract", obj_mouse_control)
instance_create_layer(0, 0, "Abstract", obj_espeak_control)
application_surface_draw_enable(false)
audio_falloff_set_model(audio_falloff_exponent_distance)
application_resize(aspect_ratio)

for (var i = 1; i <= 999; i++) {
	array_push(door_numbers_avaliable, i)
}