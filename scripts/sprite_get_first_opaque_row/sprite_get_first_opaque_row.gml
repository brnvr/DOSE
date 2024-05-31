function sprite_get_first_opaque_row(sprite, subimage) {
	var min_value;
	var n_columns;
	
	n_columns = sprite_get_width(sprite);
	min_value = -1;
	
	for (var i = 0; i < n_columns; i++) {
		var value;
		
		value = sprite_get_first_opaque_pixel_in_column(sprite, subimage, i);
		
		if (min_value == -1 || min_value > value) {
			min_value = value;	
		}
	}
	
	return min_value;
}