function object_get_index(object) {
	if (instance_number(object) == 0) {
		return object
	}
	
	return object.object_index
}