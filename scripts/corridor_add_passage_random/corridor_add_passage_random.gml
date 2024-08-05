function corridor_add_passage_random(corridor, direction) {
	var arr, coord_selected, cell_selected, random_pos, cells_used_length;
	
	arr = [];
	cells_used_length = array_length(corridor.cells_used);
	
	for (var i = 0; i < cells_used_length; i++) {
		var wall = -1;	
		var cell = corridor.grid[# corridor.cells_used[i][0], corridor.cells_used[i][1]];
		
		switch (direction) {
			case cardinal.north:
				wall = cell[corridor_cell_prop.wall_north];
				break;
				
			case cardinal.south:
				wall = cell[corridor_cell_prop.wall_south];				
				break;
				
			case cardinal.east:
				wall = cell[corridor_cell_prop.wall_east];
				break;
				
			case cardinal.west:
				wall = cell[corridor_cell_prop.wall_west];
				break;
		}
		
		if (wall >= 0) {
			array_push(arr, corridor.cells_used[i]);	
		}
	}
	
	random_pos = irandom(array_length(arr)-1);
	coord_selected = [arr[random_pos][0], arr[random_pos][1]];
	cell_selected = corridor.grid[# coord_selected[0], coord_selected[1]];
	
	switch (direction) {
		case cardinal.north:
			cell_selected[corridor_cell_prop.wall_north] = 1;
			cell_selected[corridor_cell_prop.occupied] = true;
			break;
			
		case cardinal.south:
			cell_selected[corridor_cell_prop.wall_south] = 1;
			cell_selected[corridor_cell_prop.occupied] = true;
			break;
			
		case cardinal.west:
			cell_selected[corridor_cell_prop.wall_west] = 1;
			cell_selected[corridor_cell_prop.occupied] = true;
			break;
			
		case cardinal.east:
			cell_selected[corridor_cell_prop.wall_east] = 1;
			cell_selected[corridor_cell_prop.occupied] = true;
			break;
	}
	
	return coord_selected;
}