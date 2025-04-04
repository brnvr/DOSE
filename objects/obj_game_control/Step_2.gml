if (keyboard_check_pressed(vk_escape)) {
	if (paused) {
		game_unpause()
	} else {
		if (obj_player.can_move) {
			game_pause()
		}
	}
}

if (global.camera_3d != noone) {
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

audio_bus_main.effects[AudioEffectType.Reverb1].mix = afx_reduce("reverb", "mix")
audio_bus_main.effects[AudioEffectType.LPF2].cutoff = afx_reduce("low_pass", "cutoff")

vfx_step()
afx_step()