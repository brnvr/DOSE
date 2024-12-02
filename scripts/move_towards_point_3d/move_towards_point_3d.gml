function move_towards_point_3d(px, py, pz, spd) {
	if (!variable_instance_exists(id, "z")) {
		show_error("Instance must be a 3d actor.", true);	
	}
	
	var vector = [px-x, py-y, pz-z];
	var vec_normal = vector_get_normal(vector);
	var vec_dist = vector_multiply_by_scalar(vec_normal, spd);
	
	x += vec_dist[0];
	y += vec_dist[1];
	z += vec_dist[2];
}