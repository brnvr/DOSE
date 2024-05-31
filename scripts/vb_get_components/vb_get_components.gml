enum vb_component {
	x, y, z, nx, ny, nz, r, g, b, a, u, v	
}

function vb_get_components(vbuff) {
	var buffer, components, n_vertex;
	
	components = [];
	buffer = buffer_create_from_vertex_buffer(vbuff, buffer_fixed, 1);
	n_vertex = buffer_get_size(buffer)/36;
	
	for (var i = 0; i < n_vertex; i++) {
		array_push(components, []);
		
		repeat (6) {
			array_push(components[i], buffer_read(buffer, buffer_f32));	
		}
	
		repeat (4) {
			array_push(components[i], buffer_read(buffer, buffer_u8));
		}
		
		repeat (2) {
			array_push(components[i], buffer_read(buffer, buffer_f32));	
		}
	}
	
	buffer_delete(buffer);
	
	return components;
}