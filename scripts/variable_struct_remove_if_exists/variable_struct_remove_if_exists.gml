function variable_struct_remove_if_exists(struct, name) {
	if (variable_struct_exists(struct, name)) {
		variable_struct_remove(struct,name);	
	}
}