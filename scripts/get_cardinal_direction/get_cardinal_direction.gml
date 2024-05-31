function get_cardinal_direction(degrees) {
	degrees = degrees mod 360
	
	if (degrees >= 315 || degrees < 45) {
		return cardinal.east
	} else if (degrees >= 45 && degrees < 135) {
		return cardinal.north
	} else if (degrees >= 135 && degrees < 225) {
		return cardinal.west
	} else {
		return cardinal.south
	}
}