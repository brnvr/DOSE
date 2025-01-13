function shader_set_clock_pointer(angle) {
	static u_shader = shader_get_uniform(sh_clock_pointer, "angle")
	
	shader_set(sh_clock_pointer)
	shader_set_uniform_f(u_shader, angle)
}