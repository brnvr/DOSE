function vb_load(filepath, freeze = true, format = vertex_format) {
	var buffer, vertex_buffer, model;
	
	static loaded_models = {};
	
	model = variable_struct_get(loaded_models, filepath);
	
	if (!is_undefined(model)) {
		return model;	
	}
	
    buffer = buffer_load(filepath);
    vertex_buffer = vertex_create_buffer_from_buffer(buffer, format);
	
    if (freeze) vertex_freeze(vertex_buffer);
    buffer_delete(buffer);
	
	variable_struct_set(loaded_models, filepath, vertex_buffer);
	
    return vertex_buffer;
}