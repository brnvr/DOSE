function sprite_get_draw_center_x(sprite, scale=1){
	var xoffset, xcenter;
	
	xoffset = sprite_get_xoffset(sprite);
	xcenter = sprite_get_width(sprite)*.5;
	
	return (xoffset-xcenter)*scale;
}