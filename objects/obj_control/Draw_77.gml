var fullscreen, scale, factor;

fullscreen = window_get_fullscreen();
factor = display_get_height()/540;
scale = factor*(fullscreen ? 1.5 : 1);

shader_set_vhs(
	tracking_error_distance,
	tracking_error_distance*.25,
	tracking_error_alpha,
	tracking_error_variation_factor,
	gameview_xscale,
	gameview_yscale,
	wave_amount,
	wave_offset
);

draw_surface_ext(application_surface, 0, 0, scale, scale, 0, c_white, 1);
shader_reset();

