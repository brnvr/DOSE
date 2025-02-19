u_mesh_alpha = shader_get_uniform(shader, "alpha")
u_mesh_light_direction = shader_get_uniform(shader, "light_direction")
u_mesh_light_hue = shader_get_uniform(shader, "light_hue")
u_mesh_fog_start = shader_get_uniform(shader, "fog_start")
u_mesh_fog_end = shader_get_uniform(shader, "fog_end")
u_mesh_camera_position = shader_get_uniform(shader, "camera_position")
u_mesh_lighting_enabled = shader_get_uniform(shader, "lighting_enabled")
u_mesh_fog_enabled = shader_get_uniform(shader, "fog_enabled")
u_mesh_fog_color = shader_get_uniform(shader, "fog_color")
u_mesh_shadow_color = shader_get_uniform(shader, "shadow_color")

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