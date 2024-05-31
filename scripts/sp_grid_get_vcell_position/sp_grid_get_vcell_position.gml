function sp_grid_get_vcell_position(grid, ypos) {
	return (ypos-grid.ystart) div grid.cell_height;
}