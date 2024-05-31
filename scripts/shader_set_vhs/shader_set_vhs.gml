function shader_set_vhs(tracking_error_xdistance, tracking_error_ydistance, tracking_error_alpha, shadow_color, saturation = 1, tracking_error_variation_factor = 1) {
	var tracking_error_distance, tracking_lines_texture, tracking_error_variation;
	
	static tracking_lines_image = 0;
	static tracking_error_xvariation = 0;
	static tracking_error_yvariation = 0;
	
	static get_tracking_error_variation = function(error_current, tracking_error_variation_factor) {
		var rnd_number;
		
		rnd_number = error_current + random_range(-1000, 1000);
		
		return clamp(rnd_number, -1000, 1000)/(200000/tracking_error_variation_factor);
	}
	
	tracking_error_xvariation = get_tracking_error_variation(tracking_error_xvariation, tracking_error_variation_factor);
	tracking_error_yvariation = get_tracking_error_variation(tracking_error_yvariation, tracking_error_variation_factor);
	
	tracking_error_distance = [tracking_error_xdistance, tracking_error_ydistance];
	tracking_error_variation = [tracking_error_xvariation, tracking_error_yvariation];
	tracking_lines_texture = sprite_get_texture(spr_vhs_tracking_lines, tracking_lines_image);
	
	tracking_lines_image = (tracking_lines_image + .5) mod sprite_get_number(spr_vhs_tracking_lines);
	
	shader_set(sh_vhs_filter);
	shader_set_uniform_f_array(u_vhs_shadow_color, color_get_normalized(shadow_color));
	shader_set_uniform_f(u_vhs_tracking_error_alpha, tracking_error_alpha);
	shader_set_uniform_f(u_vhs_saturation, saturation);
	texture_set_stage(u_vhs_tracking_lines, tracking_lines_texture);
	shader_set_uniform_f_array(u_vhs_tracking_error_distance, tracking_error_distance);
	shader_set_uniform_f_array(u_vhs_tracking_error_variation, tracking_error_variation);
}