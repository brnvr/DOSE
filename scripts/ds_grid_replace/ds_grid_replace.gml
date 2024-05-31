function ds_grid_replace(ds_grid, xpos, ypos, val, delete_func=undefined, empty_val=-1) {
	var prev_val;
	
	prev_val = ds_grid[# xpos, ypos];
	
	if (prev_val != empty_val) {
		if (!is_undefined(delete_func)) {
			delete_func(prev_val);	
		}
	}
	
	ds_grid[# xpos, ypos] = val;
}