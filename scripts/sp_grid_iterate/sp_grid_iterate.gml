function sp_grid_iterate(grid, callback) {
	var buffer, n_cells, vcell, hcells, hcell;

	buffer = grid.buffer;
	n_cells = buffer_get_size(buffer);
	hcells = grid.hcells;
	vcell = -1;
	hcell = -1;
	buffer_seek(buffer, buffer_seek_start, 0);
		
	for (var i = 0; i < n_cells; i++) {
		var is_obstacle;
			
		if (++hcell mod hcells == 0) {
			vcell++;
			hcell = 0;
		}
			
		is_obstacle = buffer_read(buffer, buffer_bool);
			
		callback(sp_grid_get_cell_xstart(grid, hcell), sp_grid_get_cell_ystart(grid, vcell), is_obstacle, hcell, vcell);
	}
}