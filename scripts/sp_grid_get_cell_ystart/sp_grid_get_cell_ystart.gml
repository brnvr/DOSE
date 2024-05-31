function sp_grid_get_cell_ystart(grid, vcell) {
	if (vcell > grid.vcells) {
		throw "vcell out of grid bounds.";	
	}
	
	return grid.ystart+(vcell)*grid.cell_height;	
}