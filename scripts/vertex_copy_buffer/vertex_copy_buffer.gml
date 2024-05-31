function vertex_copy_buffer(vbuff, format) {
	var buffer, vbuff_new;
	
	buffer = buffer_create_from_vertex_buffer(vbuff, buffer_fixed, 1);
	vbuff_new = vertex_create_buffer_from_buffer(buffer, format);
	
	buffer_delete(buffer);
	return vbuff_new;
}