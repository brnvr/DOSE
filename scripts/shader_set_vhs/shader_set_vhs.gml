function shader_set_vhs(
	tracking_error_xdistance, 
	tracking_error_ydistance, 
	tracking_error_alpha, 
	tracking_error_variation_factor = 1, 
	xscale = 1, 
	yscale = 1, 
	wave_amount = 0, 
	wave_offset = 0, 
	saturation = 1.0, 
	shadow_color = c_black,
	blur_radius = 0,
	blur_intensity = 0,
	screen_width = 1920,
	screen_height = 1080,
	palette = global.game_view_palette
) {
	static tracking_lines_image = 0
	static tracking_error_xvariation = 0
	static tracking_error_yvariation = 0
	
	static get_tracking_error_variation = function(error_current, tracking_error_variation_factor) {
		var rnd_number = error_current + random_range(-1000, 1000)
		
		return clamp(rnd_number, -1000, 1000)/(200000/tracking_error_variation_factor)
	}
	
	tracking_error_xvariation = get_tracking_error_variation(tracking_error_xvariation, tracking_error_variation_factor)
	tracking_error_yvariation = get_tracking_error_variation(tracking_error_yvariation, tracking_error_variation_factor)
	
	var tracking_error_distance = [tracking_error_xdistance, tracking_error_ydistance]
	var tracking_error_variation = [tracking_error_xvariation, tracking_error_yvariation]
	var tracking_lines_texture = sprite_get_texture(spr_vhs_tracking_lines, tracking_lines_image)
	var wave_gradient_texture = sprite_get_texture(spr_wave_gradient, 0)
	var dithering_map_texture = sprite_get_texture(spr_dither_pattern, 0)
	var scale = [xscale, yscale]
	
	tracking_lines_image = (tracking_lines_image + .5) mod sprite_get_number(spr_vhs_tracking_lines)
	
	shader_set(sh_vhs);
	shader_set_uniform_f(shader_get_uniform(sh_vhs, "blurRadius"), blur_radius)
	shader_set_uniform_f(shader_get_uniform(sh_vhs, "blurIntensity"), blur_intensity)
	shader_set_uniform_f_array(shader_get_uniform(sh_vhs, "screenSize"), [screen_width, screen_height])
	shader_set_uniform_f(shader_get_uniform(sh_vhs, "trackingErrorAlpha"), tracking_error_alpha)
	shader_set_uniform_f(shader_get_uniform(sh_vhs, "saturation"), saturation)
	shader_set_uniform_f_array(shader_get_uniform(sh_vhs, "shadowColor"), color_get_normalized(shadow_color))
	texture_set_stage(shader_get_sampler_index(sh_vhs, "trackingLines"), tracking_lines_texture)
	texture_set_stage(shader_get_sampler_index(sh_vhs, "wavGradient"), wave_gradient_texture)
	shader_set_uniform_f(shader_get_uniform(sh_vhs, "waveAmount"), wave_amount)
	shader_set_uniform_f(shader_get_uniform(sh_vhs, "waveOffset"), wave_offset)
	shader_set_uniform_f_array(shader_get_uniform(sh_vhs, "scale"), scale)
	shader_set_uniform_f_array(shader_get_uniform(sh_vhs, "trackingErrorDistance"), tracking_error_distance)
	shader_set_uniform_f_array(shader_get_uniform(sh_vhs, "trackingErrorVariation"), tracking_error_variation)
	shader_set_uniform_matrix_array(shader_get_uniform(sh_vhs, "palette"), palette)
	texture_set_stage(shader_get_sampler_index(sh_vhs, "ditherMap"), dithering_map_texture)
}