function angular_interpolation(value, destination, increment) {
	var difference;
	
	difference = angle_difference(value, destination);
	
	if (abs(difference) < increment) {
		return destination;
	} else if (difference > 0) {
		return value-increment;	
	} else {
		return value+increment;	
	}
}