function sprite_create_from_assembly_ext(sprite, rows, xscale, yscale, col, alpha, xorigin=0, yorigin=0) {
	var spr_new, surf, part_width, part_height, nparts, total_width, total_height;
	
	part_width = sprite_get_width(sprite)*xscale;
	part_height = sprite_get_height(sprite)*yscale;
	nparts = sprite_get_number(sprite);
	total_width = part_width*rows;
	total_height = ceil(part_height*nparts/rows);
	surf = surface_create(total_width, total_height);
	
	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	draw_sprite_assembly_ext(sprite, 0, 0, rows, xscale, yscale, col, alpha);
	
	spr_new = sprite_create_from_surface(surf, 0, 0, total_width, total_height, false, false, xorigin, yorigin);
	
	surface_reset_target();
	surface_free(surf);
	
	return spr_new; 
}