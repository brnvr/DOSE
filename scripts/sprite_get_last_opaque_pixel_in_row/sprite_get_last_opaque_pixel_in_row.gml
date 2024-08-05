function sprite_get_last_opaque_pixel_in_row(sprite, subimage, row) {
	var surf, width, height;
	
	width = sprite_get_width(sprite)
	height = sprite_get_height(sprite)
	surf = surface_create(width, height);
	
	surface_set_target(surf);
	
	draw_clear_alpha(c_black, 0);
	draw_sprite(sprite, subimage, sprite_get_xoffset(sprite), sprite_get_yoffset(sprite));
	surface_reset_target();
	
	for (var i = width-1; i >= 0; i--) {
		var pixel = surface_getpixel_ext(surf, i, row);
		var alpha = (pixel >> 24) & 255;
		
		if (alpha != 0) {
			surface_free(surf);
			return i;
		}
	}
	
	surface_free(surf);
	return -1;
}