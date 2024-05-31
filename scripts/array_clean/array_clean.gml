function array_clean(array, delete_func=undefined, empty_val = -1) {
	for (var i = 0; i < array_length(array); i++) {
		var val;
		
		val = array[i];
		
		if (!is_undefined(delete_func)) {
			delete_func(val);	
		}
		
		array[i] = empty_val;
	}
}