function shader_set_ui(saturation, color_range, shadow_color = undefined, pixel_size = 0, sprite = undefined) {
	var u_saturation, u_shadow_color, u_color_range, u_pixel_size, u_texture_dimentions, shadow_color_normalized;
	
	if (pixel_size > 1 && is_undefined(sprite)) {
		throw "\"sprite\" must be defined if \"pixel_size\" is greater than 1."
	}
	
	shader_set(sh_2d_ui)
	
	u_shadow_color = shader_get_uniform(sh_2d_ui, "shadow_color")
	u_saturation = shader_get_uniform(sh_2d_ui, "saturation")
	u_color_range = shader_get_uniform(sh_2d_ui, "color_range")
	u_pixel_size = shader_get_uniform(sh_2d_ui, "pixel_size")
	u_texture_dimentions = shader_get_uniform(sh_2d_ui, "texture_dimentions")
	
	if (is_undefined(shadow_color)) {
		shadow_color_normalized = [0, 0, 0]	
	} else {
		shadow_color_normalized = color_get_normalized(shadow_color)	
	}
	
	shader_set_uniform_f_array(u_shadow_color, shadow_color_normalized)
	shader_set_uniform_f(u_saturation, saturation)
	shader_set_uniform_f(u_color_range, color_range)
	shader_set_uniform_f(u_pixel_size, pixel_size)
	
	if (pixel_size > 0) {
		var width, height
		
		width = sprite_get_width(sprite)
		height = sprite_get_height(sprite)
		
		shader_set_uniform_f_array(u_texture_dimentions, [width, height])
	}
}