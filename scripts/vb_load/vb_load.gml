function vb_load(filepath, freeze = true, format = global.vertex_format) {
	static loaded_models = {};
	
	var model = variable_struct_get(loaded_models, filepath);
	
	if (!is_undefined(model)) {
		return model;	
	}
	
    var buffer = buffer_load(filepath);
    var vertex_buffer = vertex_create_buffer_from_buffer(buffer, format);
	
    if (freeze) vertex_freeze(vertex_buffer);
    buffer_delete(buffer);
	
	variable_struct_set(loaded_models, filepath, vertex_buffer);
	
    return vertex_buffer;
}