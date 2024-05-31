function vector_move_point(v_initial, v_final, distance) {
	var v_path, v_direction;
	
	v_path = vector_subtract(v_final, v_initial);
	v_direction = vector_multiply_by_scalar(vector_get_normal(v_path), distance);
	
	return vector_add(v_initial, v_direction);
}