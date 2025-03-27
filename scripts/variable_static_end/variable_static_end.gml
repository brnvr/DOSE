function variable_static_end() {
	if (!instance_exists(obj_static)) {
		throw "Static object doesn't exist."	
	}
	
	instance_destroy(obj_static)
}