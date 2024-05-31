function corridor_remove_door_from_cell(corridor, xcell, ycell, direction) {
	var cell;
	
	cell = corridor.grid[# xcell, ycell];
	
	switch (direction) {
		case cardinal.north:
			cell[corridor_cell_prop.door_north] = -1;
			break;
			
		case cardinal.south:
			cell[corridor_cell_prop.door_south] = -1;
			break;
			
		case cardinal.east:
			cell[corridor_cell_prop.door_east] = -1;
			break;
			
		case cardinal.west:
			cell[corridor_cell_prop.door_west] = -1;
			break;
	}
}