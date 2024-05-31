function sp_grid_is_point_meeting_cell(grid, xpos, ypos, hcell, vcell) {
		return	abs(xpos-sp_grid_get_cell_xcenter(grid, hcell) < grid.cell_width) &&
				abs(ypos-sp_grid_get_cell_ycenter(grid, vcell) < grid.cell_height);
}