function sp_grid_get_cell_xstart(grid, hcell) {
	if (hcell > grid.hcells) {
		throw "hcell out of grid bounds.";	
	}
	
	return grid.xstart+(hcell)*grid.cell_width;	
}