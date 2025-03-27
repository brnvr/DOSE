function shader_set_2d(saturation = 1, pixel_size = 0, sprite = undefined, palette = global.ui_palette) {
	if (pixel_size > 1 && is_undefined(sprite)) {
		throw "\"sprite\" must be defined if \"pixel_size\" is greater than 1."
	}
	
	shader_set(sh_2d)
	
	var u_saturation = shader_get_uniform(sh_2d, "saturation")
	var u_pixel_size = shader_get_uniform(sh_2d, "pixelSize")
	var u_texture_dimentions = shader_get_uniform(sh_2d, "textureDimensions")
	var u_palette = shader_get_uniform(sh_2d, "palette");
	var dithering_map_texture = sprite_get_texture(spr_dither_pattern, 0)

	shader_set_uniform_f(u_pixel_size, pixel_size)
	shader_set_uniform_f(u_saturation, saturation)
	
	if (pixel_size > 0) {
		var width = sprite_get_width(sprite)
		var height = sprite_get_height(sprite)
		
		shader_set_uniform_f_array(u_texture_dimentions, [width, height])
	}
	
	texture_set_stage(shader_get_sampler_index(sh_2d, "ditherMap"), dithering_map_texture)
	shader_set_uniform_matrix_array(u_palette, palette);
}