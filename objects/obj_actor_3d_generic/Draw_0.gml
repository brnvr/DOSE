if (view_current == views.view_3d) {
	shader_set(shader)
	shader_set_uniform_f(u_mesh_alpha, alpha)
	shader_set_uniform_f(u_mesh_fog_start, obj_control.fog_start)
	shader_set_uniform_f(u_mesh_fog_end, obj_control.fog_end)
	shader_set_uniform_f_array(u_mesh_light_direction, obj_control.light_direction)
	shader_set_uniform_f_array(u_mesh_light_hue, obj_control.light_hue)
	shader_set_uniform_f_array(u_mesh_camera_position, camera_3d_get_position())
	shader_set_uniform_i(u_mesh_lighting_enabled, lighting_enabled)
	shader_set_uniform_i(u_mesh_fog_enabled, fade_with_distance)
	shader_set_uniform_f_array(u_mesh_fog_color, color_get_normalized(obj_control.fog_color))
	shader_set_uniform_f_array(u_mesh_shadow_color, color_get_normalized(obj_control.fog_color))
	event_user(15)

	matrix_set(matrix_world, transformation_matrix)
	gpu_set_cullmode(cullmode)

	array_foreach(vbuff_list, function(vbuff, i) {
		if (vbuff >= 0) {
			vertex_submit(vbuff, pr_trianglelist, texture_list[i])
		}
	});

	matrix_set(matrix_world, matrix_build_identity())
	shader_reset()
}