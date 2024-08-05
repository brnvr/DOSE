function struct_select(struct, condition, first = false) {
	var arr, keys, n_keys;
	
	keys = variable_struct_get_names(struct);
	n_keys = array_length(keys);
	arr = [];
	
	for (var i = 0; i < n_keys; i++) {
		var key = keys[i];
		
		if (condition(key)) {
			if (first) return key;
			array_push(arr, variable_struct_get(struct, key));
		}
	}
	
	return arr;
}