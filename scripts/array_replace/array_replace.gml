function array_replace(array, index, val, delete_func=undefined, empty_val = -1) {
	var prev_val;
	
	if (index >= array_length(array)) {
		array[index] = val;
		return;
	}
	
	prev_val = array[index];
	
	if (!is_undefined(delete_func)) {
		if (prev_val != empty_val) {
			delete_func(prev_val);	
		}
	}
	
	array[index] = val;
}