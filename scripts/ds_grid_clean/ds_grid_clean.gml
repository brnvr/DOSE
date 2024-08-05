function ds_grid_clean(ds_grid, delete_func=undefined, empty_val=-1) {
	var width, height;
	
	width = ds_grid_width(ds_grid);
	height = ds_grid_height(ds_grid);
	for (var i = 0; i < width; i++) {
		for (var j = 0; j < height; j++) {
			var val = ds_grid[# i, j];
			
			if (val != empty_val) {
				if (!is_undefined(delete_func)) {
					delete_func(val);	
				}
			}
			
			ds_grid[# i, j] = undefined;
		}
	}
}