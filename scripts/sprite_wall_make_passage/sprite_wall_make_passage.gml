function sprite_wall_make_passage(spr, width=95, height=235) {
	var surf, output, spr_w, spr_h, x1, y1, x2, y2;
	
	spr_w = sprite_get_width(spr);
	spr_h = sprite_get_height(spr)
	surf = surface_create(spr_w, spr_h);
	
	x1 = (default_block_size-width)*.5;
	x2 = (default_block_size+width)*.5;
	y1 = default_block_size-height;
	y2 = default_block_size;
	
	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	draw_sprite(spr, 0, 0, 0);
	gpu_set_blendmode(bm_subtract);
	draw_rectangle_ext(x1-default_block_size*.1, y1, x2+default_block_size*.1, y1, x2, y2, x1, y2);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
	
	output = sprite_create_from_surface(surf, 0, 0, spr_w, spr_h, false, false, 0, 0);
	surface_free(surf);
	
	return output;
}