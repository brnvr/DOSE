function sp_follow_path(path, spd) {
	var current_cell, target_data, cells, n_cells, speed_dist_ratio;
	
	target_data = {};
	
	static update_target_data = function(path, target_data) {
		var target_cell;
		
		target_cell = path.array[path.target_index];	
		
		target_data.x = sp_grid_get_cell_xcenter(path.grid, target_cell[0]);
		target_data.y = sp_grid_get_cell_ycenter(path.grid, target_cell[1]);
		target_data.distance = point_distance(x, y, target_data.x, target_data.y);
	}
		
	cells = path.array;
	n_cells = array_length(cells);
		
	if (n_cells == 0) {
		return;	
	}
		
	current_cell = -1;
		
	if (path.target_index == -1) {
		for (var i = 0; i <  n_cells; i++) {
			var cell;
			
			cell = cells[i];
			
			if (!sp_grid_is_point_meeting_cell(path.grid, x, y, cell[0], cell[1])) {
				continue;
			}
			
			path.target_index = min(i+1, n_cells-1);
			current_cell = cells[i];
			break;
		}
		
		if (current_cell == -1) {
			path.target_index = min(1, n_cells-1);
			current_cell = cells[0];
				
			x = sp_grid_get_cell_xcenter(path.grid, current_cell[0]);
			y = sp_grid_get_cell_ycenter(path.grid, current_cell[1]);
		}
	}

	update_target_data(path, target_data);
		
	if (target_data.distance < spd) {
		if (path.target_index == n_cells-1) {
			return;
		}
			
		path.target_index++;
		
		update_target_data(path, target_data);
	}
		
	speed_dist_ratio = spd/target_data.distance;
		
	x += speed_dist_ratio * (target_data.x-x);
	y += speed_dist_ratio * (target_data.y-y);
	
	return;
}