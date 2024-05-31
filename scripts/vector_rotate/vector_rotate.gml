function vector_rotate(vec, angle) {
	var dcos_angle, dsin_angle;
	
	dcos_angle = dcos(angle);
	dsin_angle = dsin(angle);
	
	return [
		vec[0]*dcos_angle - vec[1]*dsin_angle,
		vec[0]*dsin_angle + vec[1]*dcos_angle
	];
}