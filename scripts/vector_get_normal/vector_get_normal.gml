function vector_get_normal(vector)  {
	if (!is_array(vector)) {
		show_error("Vector must be an array", true);	
	}
	
	var length, normal_vec, size;
	
	length = vector_length(vector);
	
	if (is_undefined(length)) {
		return undefined;	
	}
	
	normal_vec = [];
	size = array_length(vector);
	
	for (var i = 0; i < size; i++) {
		array_push(normal_vec, vector[i]/length);	
	}
	
	return normal_vec;
}