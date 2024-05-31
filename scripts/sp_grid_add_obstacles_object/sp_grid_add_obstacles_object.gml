function sp_grid_add_obstacles_object(grid, object) {
	with (object) {
		var hcell, vcell;
			
		hcell = sp_grid_get_hcell_instance(grid, id);
		vcell = sp_grid_get_vcell_instance(grid, id);
			
		sp_grid_set_obstacle(grid, hcell, vcell, true);
	}
}