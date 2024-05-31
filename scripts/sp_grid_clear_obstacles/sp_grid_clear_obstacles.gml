function sp_grid_clear_obstacles(grid) {
	var n_cells, buffer;
		
	buffer = grid.buffer;
	n_cells = buffer_get_size(buffer);
		
	buffer_seek(buffer, buffer_seek_start, 0);
		
	repeat (n_cells) {
		buffer_write(buffer, buffer_bool, 0);
	}
	
	SpGridClearObstacles(grid.id);
}