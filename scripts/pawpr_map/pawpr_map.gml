function pawpr_map(struct, n_slots, index_map_function, value_map_function=undefined) {
	var buffer, buffer_length, names;
	
	names = variable_struct_get_names(struct);
	buffer_length = array_length(names);
	buffer = pawpr_buffer(n_slots);
	
	for (var i = 0; i < buffer_length; i++) {
		var key, index;
		
		key = names[i];
		index = index_map_function(key, false);
		
		if (!is_undefined(index)) {
			var value;
			
			value = variable_struct_get(struct, key);
			pawpr_buffer_add(buffer, [index, is_undefined(value_map_function) ? value : value_map_function(value)]);	
	
		}
	}
	
	return buffer;
}