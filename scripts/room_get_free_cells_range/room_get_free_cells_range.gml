function room_get_free_cells_range(room, min_x, min_y, max_x, max_y) {
	var arr;
	
	arr = [];
	
	for (var xx = 0; xx < room.hlength; xx++) {
		var mx;
		
		if (xx < min_x || xx > max_x) {
			continue;	
		}
		
		mx = array_length(room.free_cells[xx]);
		
		for (var i = 0; i < mx; i++) {
			var yy;
			
			yy = room.free_cells[xx][i];
			
			if (yy < min_y || yy > max_y) {
				continue;	
			}
			
			array_push(arr, [xx, yy]);
		}
	}
	
	return arr;
}