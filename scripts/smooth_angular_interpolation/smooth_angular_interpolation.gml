function smooth_angular_interpolation(start, destination, rate = 0.1) {
	var difference;
	
	difference = angle_difference(start, destination);
	
	if (abs(difference) <= math_get_epsilon()) {
		return destination;	
	}
	
	return start - difference*rate;
}