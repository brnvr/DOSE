function sprite_get_inner_top(sprite, subimage = 0, search_interval = 2) {
	var smallest_value;
	
	smallest_value = 0;
	
	for (var i = 0; i < sprite_get_width(sprite); i += search_interval) {
		var first_opaque_pixel;
		
		first_opaque_pixel = sprite_get_first_opaque_pixel_in_column(sprite, subimage, i);
	
		if (first_opaque_pixel != -1) {
			if (first_opaque_pixel < smallest_value || smallest_value = 0) {
				smallest_value = first_opaque_pixel;	
			}
		}
	}
	
	return sprite_get_height(sprite)-smallest_value;
}