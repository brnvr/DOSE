function sp_grid_get_cell_xcenter(grid, hcell) {
	return sp_grid_get_cell_xstart(grid, hcell) + grid.cell_width*.5;
}