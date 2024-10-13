function struct_duplicate(struct, filter = undefined) {
	var new_struct;
	
	new_struct = {};
	struct_copy(struct, new_struct, filter);
	
	return new_struct;
}