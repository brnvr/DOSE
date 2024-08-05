function bbox_create_from_buffer(buffer, vertex_size) {
	var buffer_size, min_x, min_y, min_z, max_x, max_y, max_z;
	
	buffer_size = buffer_get_size(buffer);
	
	for (var i = 0; i < buffer_size; i+=vertex_size) {
		buffer_seek(buffer, buffer_seek_start, i);
		
		var vertex_x = buffer_read(buffer, buffer_f32);
		var vertex_y = buffer_read(buffer, buffer_f32);
		var vertex_z = buffer_read(buffer, buffer_f32);
		
		min_x = i == 0 ? vertex_x : min(min_x, vertex_x);
		min_y = i == 0 ? vertex_y : min(min_y, vertex_y);
		min_z = i == 0 ? vertex_z : min(min_z, vertex_z);
		
		max_x = i == 0 ? vertex_x : max(max_x, vertex_x);
		max_y = i == 0 ? vertex_y : max(max_y, vertex_y);
		max_z = i == 0 ? vertex_z : max(max_z, vertex_z);
	}
	
	return [min_x, min_y, min_z, max_x, max_y, max_z];
}