function struct_duplicate(struct, filter = pointer_null) {
	var new_struct;
	
	new_struct = {};
	struct_copy(struct, new_struct, filter);
	
	return new_struct;
}