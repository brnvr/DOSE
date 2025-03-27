function variable_struct_get_ext(struct, name, default_value) {
	var attribute = variable_struct_get(struct, name)
	
	return (!is_undefined(attribute)) ? attribute : default_value
}