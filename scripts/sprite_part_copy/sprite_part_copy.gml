function sprite_part_copy(sprite, subimage, xx, yy, w, h, xoffset=0, yoffset=0) {
	var surf, sprite_new;
	
	surf = surface_create(w, h);
	surface_set_target(surf);
	
	draw_clear_alpha(c_black, 0);
	draw_sprite(sprite, 0, sprite_get_xoffset(sprite)-xx, sprite_get_yoffset(sprite)-yy);
	surface_reset_target();
	
	sprite_new = sprite_create_from_surface(surf, 0, 0, w, h, false, false, xoffset, yoffset);
	surface_free(surf);
	
	return sprite_new;
}