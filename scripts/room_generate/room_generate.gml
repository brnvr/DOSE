function room_generate(room, min_length=5, max_length=5) {
	room.reset();
	
	room.hlength = irandom_range(min_length, max_length);
	room.vlength = irandom_range(min_length, max_length);
	room.free_cells = array_2d_create(room.hlength);
	
	for (var xx = 0; xx < room.hlength; xx++) {
		for (var yy = 0; yy < room.vlength; yy++) {
			array_push(room.free_cells[xx], yy);
		}
	}
	
	for (var i = 0; i < room.hlength; i++) {
		if (take_chance(room.prob_door)) {
			array_push(room.walls.north, 2);
			room_occupy_cell(room, i, 0);
		} else {
			array_push(room.walls.north, 0);	
		}
		
		if (take_chance(room.prob_door)) {
			array_push(room.walls.south, 2);	
			room_occupy_cell(room, i, room.vlength-1);
		} else {
			array_push(room.walls.south, 0);	
		}
	}
	
	for (var i = 0; i < room.vlength; i++) {
		if (take_chance(room.prob_door)) {
			array_push(room.walls.west, 2);	
			room_occupy_cell(room, 0, i);
		} else {
			array_push(room.walls.west, 0);	
		}
		
		if (take_chance(room.prob_door)) {
			array_push(room.walls.east, 2);
			room_occupy_cell(room, room.hlength-1, i);
		} else {
			array_push(room.walls.east, 0);	
		}
	}
}