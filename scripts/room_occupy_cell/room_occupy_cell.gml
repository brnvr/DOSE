function room_occupy_cell(room, xcell, ycell) {
	var index;
	
	index = array_find(room.free_cells[xcell], ycell);
	
	if (index == -1) return -1;
	
	array_delete(room.free_cells[xcell], index, 1);
	
	return index;
}