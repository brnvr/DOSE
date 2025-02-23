/// @description vfx filters

enum vfx_filter_types {
	envenomation	
}

global.vfx_filter_functions = []

global.vfx_filter_functions[vfx_filter_types.envenomation] = function() {
	return {
		blur_radius: new Interpolator(0.5, 10, 0.001),
		wave_offset: new Waver(0, 1, 0.001),
		wave_amount: new Interpolator(0, 0.4*obj_player.envenoming, 0.0001*obj_player.envenoming),
		gameview_xscale: new Interpolator(1, 1 + 0.8 * obj_player.envenoming, 0.0002)
	}
}

global.vfx_default_values = {
	blur_radius: 0,
	blur_intensity: 0.5,
	wave_amount: 0,
	wave_offset: 0,
	gameview_xscale: 1,
	gameview_yscale: 1
}	