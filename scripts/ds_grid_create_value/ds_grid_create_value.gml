function ds_grid_create_value(width, height, val=-1) {
	var ds_grid;
	
	ds_grid = ds_grid_create(width, height);
	ds_grid_add_region(ds_grid, 0, 0, width, height, val);
	
	return ds_grid;
}