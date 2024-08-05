function variable_struct_get_values(struct) {
	var values, keys, n_keys;
	
	keys = variable_struct_get_names(struct);
	n_keys = array_length(keys);
	values = [];
	
	for (var i = 0; i < n_keys; i++) {
		var key = keys[i];
		var value = variable_struct_get(struct, key);
		array_push(values, value);
	}
	
	return values;
}