function sp_grid_set_obstacle(grid, hcell, vcell, is_obstacle) {
	var offset;
	
	offset = grid.hcells*vcell + hcell;
	
	buffer_poke(grid.buffer, offset, buffer_bool, is_obstacle ? 1 : 0);
	SpGridSetObstacle(grid.id, hcell, vcell, is_obstacle);
}