function variable_static_get(object, key) {
	var object_name = object_get_name(object)
	
	if (is_undefined(obj_static.variables[$ object_name])) {
		return undefined
	}
	
	return obj_static.variables[$ object_name][$ key]
}