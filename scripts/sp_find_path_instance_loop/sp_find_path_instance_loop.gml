function sp_find_path_instance_loop(path, instance, instance_destination, period, search_directions=1) {
	var hcell_start, vcell_start, hcell_dest, vcell_dest;
		
	hcell_start = sp_grid_get_hcell_instance(path.grid, instance);
	vcell_start = sp_grid_get_vcell_instance(path.grid, instance);
	hcell_dest = sp_grid_get_hcell_instance(path.grid, instance_destination);
	vcell_dest = sp_grid_get_vcell_instance(path.grid, instance_destination);
		
	return sp_find_path_loop(path, hcell_start, vcell_start, hcell_dest, vcell_dest, period, search_directions);
}