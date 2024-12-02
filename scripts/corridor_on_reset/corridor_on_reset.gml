function corridor_on_reset() {
	var size;
	
	size = ds_grid_width(grid);
	
	ds_grid_set_region(grid, 0, 0, size-1, size-1, -1);
	
	cells_used = [];
	cell_processing = 0;
	
	doors = [];
	door_coords = [[],[],[],[]];
	staircase_coords = [[],[],[],[]];
}