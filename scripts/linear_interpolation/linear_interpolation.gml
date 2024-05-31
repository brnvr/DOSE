function linear_interpolation(value, destination, increment) {
	if (abs(value-destination) < increment) {
		return destination;
	} else if (value > destination) {
		return value-increment;	
	} else {
		return value+increment;	
	}
}