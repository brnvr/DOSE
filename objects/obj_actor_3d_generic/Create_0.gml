if (is_undefined(bbox_list)) {
	bbox_list = []	
}

if (is_undefined(vbuff_list)) {
	vbuff_list = []	
}

if (is_undefined(texture_list)) {
	texture_list = []	
}

if (array_length(texture_list) == 0 && sprite_index >= 0) {
	texture_list = [sprite_get_texture(sprite_index, image_index)]
}

if (auto_bbox) {
	bbox_list = [bbox_create_from_vertex_buffer(vbuff_list[0])]
}

bbox_transformed_list = []
transformation_matrix = []

actor_3d_update_bbox()
actor_3d_retrive_previous_properties()
actor_3d_update_transformation_matrix()