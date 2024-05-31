function shader_set_ui(saturation, color_levels, pixel_size = 0, sprite = undefined) {
	var u_saturation, u_color_levels, u_pixel_size, u_texture_dimentions;
	
	if (pixel_size > 1 && is_undefined(sprite)) {
		throw "\"sprite\" must be defined if \"pixel_size\" is greater than 1."
	}
	
	shader_set(sh_2d_ui)
	
	u_saturation = shader_get_uniform(sh_2d_ui, "saturation")
	u_color_levels = shader_get_uniform(sh_2d_ui, "color_levels")
	u_pixel_size = shader_get_uniform(sh_2d_ui, "pixel_size")
	u_texture_dimentions = shader_get_uniform(sh_2d_ui, "texture_dimentions")
	
	shader_set_uniform_f(u_saturation, saturation)
	shader_set_uniform_f(u_color_levels, color_levels)
	shader_set_uniform_f(u_pixel_size, pixel_size)
	
	if (pixel_size > 0) {
		var width, height
		
		width = sprite_get_width(sprite)
		height = sprite_get_height(sprite)
		
		shader_set_uniform_f_array(u_texture_dimentions, [width, height])
	}
}