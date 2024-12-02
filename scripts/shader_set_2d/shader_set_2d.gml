function shader_set_2d(pixel_size = 0, sprite = undefined, palette = global.ui_palette) {
	if (pixel_size > 1 && is_undefined(sprite)) {
		throw "\"sprite\" must be defined if \"pixel_size\" is greater than 1."
	}
	
	shader_set(sh_2d)
	
	var u_shadow_color = shader_get_uniform(sh_2d, "shadow_color")
	var u_pixel_size = shader_get_uniform(sh_2d, "pixel_size")
	var u_texture_dimentions = shader_get_uniform(sh_2d, "texture_dimentions")
	var u_palette = shader_get_uniform(sh_vhs, "palette");

	shader_set_uniform_f(u_pixel_size, pixel_size)
	
	if (pixel_size > 0) {
		var width, height
		
		width = sprite_get_width(sprite)
		height = sprite_get_height(sprite)
		
		shader_set_uniform_f_array(u_texture_dimentions, [width, height])
	}

	shader_set_uniform_matrix_array(u_palette, palette);
}