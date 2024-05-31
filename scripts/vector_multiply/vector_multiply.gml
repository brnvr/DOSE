function vector_multiply(vec0, vec1){
	if (!is_array(vec0) || !is_array(vec1)) {
		show_error("Vector must be an array", true);	
	}
	
	var size, mult_vec;
	
	size = min(array_length(vec0), array_length(vec1));
	mult_vec = [];
	
	for (var i = 0; i < size; i++) {
		array_push(mult_vec, vec0[i]*vec1[i]);	
	}
	
	return mult_vec;
}