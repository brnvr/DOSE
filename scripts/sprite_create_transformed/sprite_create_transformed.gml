function sprite_create_transformed(spr, xscale, yscale, angle) {
	var surf, width, height, xorigin, yorigin, new_sprite, new_xorigin, new_yorigin, n_images;
	
	width = sprite_get_width(spr);
	height = sprite_get_height(spr);
	xorigin = sprite_get_xoffset(spr);
	yorigin = sprite_get_yoffset(spr);
	n_images = sprite_get_number(spr);
	surf = surface_create(width, height);
	
	new_xorigin = xscale > 0 ? xorigin*xscale : -(width-xorigin)*xscale;
	new_yorigin = yscale > 0 ? yorigin*yscale : -(height-yorigin)*yscale;
	
	surface_set_target(surf);
	
	for (var i = 0; i < n_images; i++) {
		draw_clear_alpha(c_black, 0);
		draw_sprite_ext(spr, i, new_xorigin, new_yorigin, xscale, yscale, angle, c_white, 1);
		
		if (i == 0) {
			new_sprite = sprite_create_from_surface(surf, 0, 0, width*abs(xscale), height*abs(yscale), false, false, new_xorigin, new_yorigin);	
		} else {
			sprite_add_from_surface(new_sprite, surf, 0, 0, width*abs(xscale), height*abs(yscale), false, false);	
		}
	}
	
	surface_reset_target();
	surface_free(surf);
	
	return new_sprite;
}