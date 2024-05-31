function door_get_cardinal_position(door, xpos, ypos) {
	switch (door.orientation) {
		case alignment.vertical:
			if (xpos > door.x) return cardinal.east;
			return cardinal.west;
			
		case alignment.horizontal:
			if (ypos > door.y) return cardinal.south;
			return cardinal.north;
	}
}