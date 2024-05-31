function color_get_normalized(color) {
	var color_array;
	
	color_array = color_get_array(color);
	
	return [color_array[0]/255, color_array[1]/255, color_array[2]/255];
}