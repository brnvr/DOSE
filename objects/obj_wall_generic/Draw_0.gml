if (view_current == views.view_3d) {
	if (draw_back && obj_player.door_passing != noone && obj_player.door_passing.is_open) {
		shader_set(sh_3d_mesh);
		shader_set_uniform_f(u_mesh_alpha, 1);
		shader_set_uniform_f(u_mesh_fog_start, -5000);
		shader_set_uniform_f(u_mesh_fog_end, -5000);
		shader_set_uniform_f_array(u_mesh_camera_position, camera_3d_get_position());
		shader_set_uniform_i(u_mesh_lighting_enabled, false);
		shader_set_uniform_i(u_mesh_fog_enabled, true);
		shader_set_uniform_f_array(u_mesh_fog_color, color_get_normalized(obj_control.fog_color));
		shader_set_uniform_f(u_mesh_color_levels, 0);
	
		matrix_set(matrix_world, transformation_matrix);
		gpu_set_cullmode(cullmode == cull_clockwise ? cull_counterclockwise : cull_clockwise);
		vertex_submit(vbuff_list[0], pr_trianglelist, sprite_get_texture(sprite_index, 0));
		matrix_set(matrix_world, matrix_build_identity());
	}

	event_inherited();
}