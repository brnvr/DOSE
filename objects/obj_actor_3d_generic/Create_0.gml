u_mesh_alpha = shader_get_uniform(shader, "alpha")
u_mesh_light_direction = shader_get_uniform(shader, "lightDirection")
u_mesh_light_hue = shader_get_uniform(shader, "lightHue")
u_mesh_fog_start = shader_get_uniform(shader, "fogStart")
u_mesh_fog_end = shader_get_uniform(shader, "fogEnd")
u_mesh_camera_position = shader_get_uniform(shader, "cameraPosition")
u_mesh_lighting_enabled = shader_get_uniform(shader, "lightingEnabled")
u_mesh_fog_enabled = shader_get_uniform(shader, "fogEnabled")
u_mesh_fog_color = shader_get_uniform(shader, "fogColor")
u_mesh_shadow_color = shader_get_uniform(shader, "shadowColor")

bbox_list = bbox_list ?? []	
vbuff_list = vbuff_list ?? []	
texture_list = texture_list ?? []	

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