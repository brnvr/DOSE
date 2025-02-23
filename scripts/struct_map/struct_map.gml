function struct_map(struct, callback) {
	var new_struct = {}
	
	struct_foreach(struct, method({ new_struct, callback }, function(key, value) {
		new_struct[$ key] = callback(value)
	}))
	
	return new_struct
}