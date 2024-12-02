function shader_set_vhs(tracking_error_xdistance, tracking_error_ydistance, tracking_error_alpha, tracking_error_variation_factor = 1, xscale = 1, yscale = 1, wave_amount = 0, wave_offset = 0, palette = global.game_view_palette) {
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
	var scale = [xscale, yscale]
	
	tracking_lines_image = (tracking_lines_image + .5) mod sprite_get_number(spr_vhs_tracking_lines)
	
	shader_set(sh_vhs);
	shader_set_uniform_f(shader_get_uniform(sh_vhs, "tracking_error_alpha"), tracking_error_alpha)
	texture_set_stage(shader_get_sampler_index(sh_vhs, "tracking_lines"), tracking_lines_texture)
	texture_set_stage(shader_get_sampler_index(sh_vhs, "wave_gradient"), wave_gradient_texture)
	shader_set_uniform_f(shader_get_uniform(sh_vhs, "wave_amount"), wave_amount)
	shader_set_uniform_f(shader_get_uniform(sh_vhs, "wave_offset"), wave_offset)
	shader_set_uniform_f_array(shader_get_uniform(sh_vhs, "scale"), scale)
	shader_set_uniform_f_array(shader_get_uniform(sh_vhs, "tracking_error_distance"), tracking_error_distance)
	shader_set_uniform_f_array(shader_get_uniform(sh_vhs, "tracking_error_variation"), tracking_error_variation)
	shader_set_uniform_matrix_array(shader_get_uniform(sh_vhs, "palette"), palette)
}