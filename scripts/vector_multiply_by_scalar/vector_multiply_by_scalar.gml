function vector_multiply_by_scalar(vector, scalar){
	if (!is_array(vector)) {
		show_error("Vector must be an array", true);	
	}
	
	var size, mult_vec;
	
	size = array_length(vector);
	mult_vec = [];
	
	for (var i = 0; i < size; i++) {
		array_push(mult_vec, vector[i]*scalar);
	}
	
	return mult_vec;
}