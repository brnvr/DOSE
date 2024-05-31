function sp_find_path(path, hcell_start, vcell_start, hcell_dest, vcell_dest, search_directions=1) {
	return SpGridFindPath(path.grid.id, path.id, hcell_start, vcell_start, hcell_dest, vcell_dest, search_directions, true);
}