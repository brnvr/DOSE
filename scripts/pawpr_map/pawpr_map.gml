function pawpr_map(struct, n_slots, index_map_function, value_map_function=undefined) {
	var _names = variable_struct_get_names(struct);
	var _buffer_length = array_length(_names);
	var _buffer = pawpr_buffer(n_slots);
	
	for (var i = 0; i < _buffer_length; i++) {
		var key = _names[i];
		var index = index_map_function(key, false);

		if (!is_undefined(index)) {
			var value = variable_struct_get(struct, key);
			pawpr_buffer_add(_buffer, [index, is_undefined(value_map_function) ? value : value_map_function(value)]);	
	
		}
	}
	
	return _buffer;
}