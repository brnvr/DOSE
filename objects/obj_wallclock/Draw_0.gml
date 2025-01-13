event_inherited();

if (view_current == views.view_3d) {
	

	matrix_set(matrix_world, transformation_matrix)
	gpu_set_cullmode(cullmode)
	gpu_set_texrepeat(false)
	shader_set_clock_pointer(-obj_clock_control.seconds_angle)
	vertex_submit(vbuff_list[0], pr_trianglelist, sprite_get_texture(spr_wallclock, 1))
	shader_set_clock_pointer(-obj_clock_control.minutes_angle)
	vertex_submit(vbuff_list[0], pr_trianglelist, sprite_get_texture(spr_wallclock, 2))
	shader_set_clock_pointer(-obj_clock_control.hours_angle)
	vertex_submit(vbuff_list[0], pr_trianglelist, sprite_get_texture(spr_wallclock, 3))
	shader_reset()
	gpu_set_texrepeat(true)
	matrix_set(matrix_world, matrix_build_identity())
	
}