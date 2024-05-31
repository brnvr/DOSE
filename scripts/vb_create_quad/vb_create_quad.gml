function vb_create_quad(p0, p1, p2, p3, nx, ny, nz, color, alpha, tex_xstart, tex_ystart, tex_xrepeat, tex_yrepeat, format) {
	var vbuff;

	vbuff = vertex_create_buffer();
	
	vertex_begin(vbuff, format);
	vb_add_quad(vbuff, p0, p1, p2, p3, nx, ny, nz, color, alpha, tex_xstart, tex_ystart, tex_xrepeat, tex_yrepeat);
	vertex_end(vbuff);
	
	vertex_freeze(vbuff);
	
	return vbuff;
}