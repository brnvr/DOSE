if (keyboard_check_pressed(vk_escape)) {
	if (paused) {
		game_unpause();
	} else {
		if (obj_player.can_move) {
			game_pause();
		}
	}
}

event_user(0)

if (global.camera_3d != noone) {
	show_debug_message([obj_player.x, obj_player.y])
	audio_listener_position(global.camera_3d.x, global.camera_3d.y, global.camera_3d.z);

	audio_listener_orientation(
		global.camera_3d.xfrom-global.camera_3d.xto,
		global.camera_3d.yfrom-global.camera_3d.yto,
		global.camera_3d.zfrom-global.camera_3d.zto,
		global.camera_3d.xup,
		global.camera_3d.yup,
		global.camera_3d.zup
	)
}

vfx_step()
/*if (envenomation_effect_on) {
	if (wave_amount < 0.4 * obj_player.envenoming) {
		wave_amount += 0.0001 * obj_player.envenoming
	}
	
	if (gameview_xscale < 1 + 0.8 * obj_player.envenoming) {
		gameview_xscale += 0.0002 * obj_player.envenoming
	}
	
	wave_offset = (wave_offset + 0.001) mod 1
	
	obj_vignette.alpha = min(1, obj_vignette.alpha+0.0002)
	blur_radius = min(10, blur_radius+0.001)
}

if (resetting_vignette) {
	obj_vignette.alpha = max(0, obj_vignette.alpha-0.001)
	
	if (obj_vignette.alpha <= 0) {
		resetting_vignette = false
	}
}


if (resetting_wave) {
	var wave_spd = 0.001
	var scale_spd = wave_spd * 2
	
	if (abs(wave_amount) < wave_spd && abs(gameview_xscale) < 1 + scale_spd) {
		wave_amount = 0
		gameview_xscale = 1
		resetting_wave = false
	}
	
	wave_amount = linear_interpolation(wave_amount, 0, wave_spd)
	gameview_xscale = linear_interpolation(gameview_xscale, 1, scale_spd)
}*/