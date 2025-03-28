/// @description fx filters

enum fx_filter_types {
	losing_consciousness
}

global.vfx_filter_functions = []
global.sfx_filter_functions = []

global.vfx_filter_functions[fx_filter_types.losing_consciousness] = function() {
	var time = 30/obj_player.envenoming
	return {
		blur_radius: new TimedInterpolator(0.5, 10, time),
		desaturation: new TimedInterpolator(0, 1-obj_game_control.saturation, time),
		wave_offset: new Waver(0, 1, 0.001),
		wave_amount: new TimedInterpolator(0, 0.4*obj_player.envenoming, time),
		gameview_xscale: new TimedInterpolator(1, 1 + 0.6 * obj_player.envenoming, time),
	}
}

global.vfx_default_values = {
	desaturation:  0,
	blur_radius: 0,
	blur_intensity: 0.5,
	wave_amount: 0,
	wave_offset: 0,
	gameview_xscale: 1,
	gameview_yscale: 1
}

global.sfx_filter_functions[fx_filter_types.losing_consciousness] = function() {
	return {
			
	}
}