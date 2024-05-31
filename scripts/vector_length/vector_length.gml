function vector_length(vector) {
	if (!is_array(vector)) {
		show_error("Vector must be an array", true);	
	}
	
	var size, total;
	
	size = array_length(vector);
	total = 0;
	
	for (var i = 0; i < size; i++) {
		total+=sqr(vector[i]);
	}
	
	if (total == 0) {
		return undefined;	
	}
	
	return sqrt(total);
}