function array_2d_create(width) {
	var arr;
	
	for (var xx = 0; xx < width; xx++) {
		arr[xx] = [];
	}
	
	return arr;
}