function sp_grid_set_obstacle_position(grid, xpos, ypos, is_obstacle) {
	var hcell, vcell;
		
	hcell = sp_grid_get_hcell_position(grid, xpos);
	vcell = sp_grid_get_vcell_position(grid, ypos);
			
	sp_grid_set_obstacle(grid, hcell, vcell, is_obstacle);
}