var fullscreen = window_get_fullscreen()
var factor = display_get_height()/540
var scale = factor*(fullscreen ? 1.5 : 1)

var gameview_xscale = vfx_reduce("gameview_xscale")
var gameview_yscale = vfx_reduce("gameview_yscale")
var wave_amount = vfx_reduce("wave_amount")
var wave_offset = vfx_reduce("wave_offset")
var blur_radius = vfx_reduce("blur_radius")
var blur_intensity = vfx_reduce("blur_intensity")

shader_set_vhs(
	tracking_error_distance,
	tracking_error_distance*.25,
	tracking_error_alpha,
	tracking_error_variation_factor,
	gameview_xscale,
	gameview_yscale,
	wave_amount,
	wave_offset,
	saturation, 
	fog_color,
	blur_radius,
	blur_intensity
);

draw_surface_ext(application_surface, 0, 0, scale, scale, 0, c_white, 1);
shader_reset();

