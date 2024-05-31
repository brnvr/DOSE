function bbox_create_from_vertex_buffer(vbuffer, vertex_size = 36) {
	var buffer, bbox;
		
	buffer = buffer_create_from_vertex_buffer(vbuffer, buffer_fixed, 1);
	bbox = bbox_create_from_buffer(buffer, vertex_size);
		
	buffer_delete(buffer);
	
	return bbox;
}