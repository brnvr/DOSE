function set_static(object, key, value) {
	var object_name = object_get_name(object)
	
	if (is_undefined(obj_static.variables[$ object_name])) {
		obj_static.variables[$ object_name] = {}
	}
	
	obj_static.variables[$ object_name][$ key] = value
}