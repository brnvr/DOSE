function room_add_passage_random(room, direction) {
	var arr, index;
	
	switch (direction) {
		case cardinal.north:
			index = irandom(array_length(room.walls.north)-1);
			arr = room.walls.north;
			room_occupy_cell(room, index, 0);
			break;
			
		case cardinal.south:
			index = irandom(array_length(room.walls.south)-1);
			arr = room.walls.south;
			room_occupy_cell(room, index, room.vlength-1);
			break;
			
		case cardinal.west:
			index = irandom(array_length(room.walls.west)-1);
			arr = room.walls.west;
			room_occupy_cell(room, 0, index);
			
			break;
			
		case cardinal.east:
			index = irandom(array_length(room.walls.east)-1);
			arr = room.walls.east;
			room_occupy_cell(room, room.hlength-1, index);
			
			break;		
	}
	
	arr[index] = 1;
	return index;
}