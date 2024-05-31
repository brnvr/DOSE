function sp_path_create(grid) {
	var path;
	
	path = {
		array : [],
		target_index: -1,
		timer: 0,
		grid: grid,
		id: array_length(grid.paths)
	}
	
	array_push(grid.paths, path);
	
	return path;
}