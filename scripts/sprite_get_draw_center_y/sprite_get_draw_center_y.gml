function sprite_get_draw_center_y(sprite, scale=1){
	var yoffset, ycenter;
	
	yoffset = sprite_get_yoffset(sprite);
	ycenter = sprite_get_height(sprite)*.5;
	
	return (yoffset-ycenter)*scale;
}