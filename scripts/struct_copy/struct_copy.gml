function struct_copy(struct_src, struct_dest, filter = pointer_null) {
	var keys, n_keys;
	
	keys = variable_struct_get_names(struct_src);
	n_keys = array_length(keys);
	
	for (var i = 0; i < n_keys; i++) {
		var key, value;
		
		key = keys[i];
		value = variable_struct_get(struct_src, key);
	
		if (filter != pointer_null) {
			if (!is_array(filter)) show_error("Filter must be an array", true);
			
			var filter_length, skip;
			
			skip = false;
			filter_length = array_length(filter);
			
			for (var j = 0; j < filter_length; j++) {
				if (filter[j] == key) break;
				if (j == filter_length-1) skip = true;
			}
			
			if (skip) continue;
		}
	
		variable_struct_set(struct_dest, key, value);
	}
}