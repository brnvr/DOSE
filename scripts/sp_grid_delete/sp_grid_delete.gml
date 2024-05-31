function sp_grid_delete(grid) {
	SpGridDelete(grid.id);
	buffer_delete(grid.buffer);
	
	delete grid;
}