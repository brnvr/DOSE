function angular_opposite(ang) {
	if (ang == angular.clockwise) {
		return angular.counterclockwise;	
	}
	
	return angular.clockwise;
}