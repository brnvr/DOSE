if (instance_exists(obj_instant_camera_control)) {
	shader_set_uniform_i(u_mesh_lighting_enabled, true)	
			
	if (is_framed) {
		shader_set_uniform_f_array(u_mesh_light_hue, [1.2, 1.2, 1.2])
	}
}