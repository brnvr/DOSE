function sp_grid_get_cell_ycenter(grid, vcell) {
	return sp_grid_get_cell_ystart(grid, vcell) + grid.cell_height*.5;
}