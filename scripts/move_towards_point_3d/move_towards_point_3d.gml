function move_towards_point_3d(px, py, pz, spd) {
	if (!variable_instance_exists(id, "z")) {
		show_error("Instance must be a 3d actor.", true);	
	}
	
	var vector, vec_normal, vec_dist;
	
	vector = [px-x, py-y, pz-z];
	vec_normal = vector_get_normal(vector);
	vec_dist = vector_multiply_by_scalar(vec_normal, spd);
	
	x += vec_dist[0];
	y += vec_dist[1];
	z += vec_dist[2];
}