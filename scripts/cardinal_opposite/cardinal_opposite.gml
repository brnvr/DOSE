function cardinal_opposite(direction) {
	switch (direction) {
		case cardinal.south:
			return cardinal.north;
			
		case cardinal.north:
			return cardinal.south;
			
		case cardinal.east:
			return cardinal.west;
			
		case cardinal.west:
			return cardinal.east;
	}
}