function sp_find_path_loop(path, hcell_start, vcell_start, hcell_dest, vcell_dest, period, search_directions=1) {
	if (path.timer <= 0) {
		if (sp_find_path(path, hcell_start, vcell_start, hcell_dest, vcell_dest, search_directions)) {
			path.timer = period;
		}
			
		return path.timer;
	}
		
	path.timer -= 1;
		
	return path.timer;
}