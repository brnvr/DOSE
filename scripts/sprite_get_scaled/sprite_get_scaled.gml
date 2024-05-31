function sprite_get_scaled(sprite_src, xscale, yscale) {
	var spr, surf, width, height, xoffset, yoffset, n_images;
	
	width = sprite_get_width(sprite_src)*xscale;
	height = sprite_get_height(sprite_src)*yscale;
	xoffset = sprite_get_xoffset(sprite_src)*xscale;
	yoffset = sprite_get_yoffset(sprite_src)*yscale;
	surf = surface_create(width, height);
	n_images = sprite_get_number(sprite_src);
	
	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	draw_sprite_ext(sprite_src, 0, xoffset, yoffset, xscale, yscale, 0, c_white, 1);
	spr = sprite_create_from_surface(surf, 0, 0, width, height, false, false, xoffset, yoffset);
	
	for (var i = 1; i < n_images; i++) {
		draw_sprite_ext(sprite_src, i, 0, 0, xscale, yscale, 0, c_white, 1);
		sprite_add_from_surface(spr, surf, xoffset, yoffset, width, height, false, false);
	}
	
	surface_reset_target();
	surface_free(surf);
	return spr;
}