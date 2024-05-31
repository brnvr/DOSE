function cardinal_get_orientation(cardinal_direction) {
	if (cardinal_direction == cardinal.east || cardinal_direction == cardinal.west) {
		return alignment.vertical;	
	} else {
		return alignment.horizontal;	
	}
}