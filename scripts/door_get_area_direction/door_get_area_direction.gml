function door_get_area_direction(door, area) {
	if (door.areas[cardinal.south] == area) return cardinal.south;
	if (door.areas[cardinal.north] == area) return cardinal.north;
	if (door.areas[cardinal.east] == area) return cardinal.east;
	if (door.areas[cardinal.west] == area) return cardinal.west;
	
	throw $"Area is not assign to door {door}";
}