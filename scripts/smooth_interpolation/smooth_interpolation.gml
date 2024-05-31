function smooth_interpolation(start, destination, rate = 0.5) {
	if (abs(destination-start) <= math_get_epsilon()) {
		return destination;	
	}
	
	return start + (destination-start)*rate;
}