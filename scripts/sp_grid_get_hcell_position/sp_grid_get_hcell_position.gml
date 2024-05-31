function sp_grid_get_hcell_position(grid, xpos) {
	return (xpos-grid.xstart) div grid.cell_width;
}