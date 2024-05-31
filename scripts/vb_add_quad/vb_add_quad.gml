function vb_add_quad(vbuff, p0, p1, p2, p3, nx, ny, nz, color, alpha, tex_xstart, tex_ystart, tex_xrepeat, tex_yrepeat) {
	vb_add_point(vbuff, p0[0], p0[1], p0[2], nx, ny, nz, color, alpha, tex_xstart, tex_ystart);
	vb_add_point(vbuff, p1[0], p1[1], p1[2], nx, ny, nz, color, alpha, tex_xstart+tex_xrepeat, tex_ystart);
	vb_add_point(vbuff, p2[0], p2[1], p2[2], nx, ny, nz, color, alpha, tex_xstart+tex_xrepeat, tex_ystart+tex_yrepeat);
	
	vb_add_point(vbuff, p3[0], p3[1], p3[2], nx, ny, nz, color, alpha, tex_xstart, tex_ystart+tex_yrepeat);
	vb_add_point(vbuff, p0[0], p0[1], p0[2], nx, ny, nz, color, alpha, tex_xstart, tex_ystart);
	vb_add_point(vbuff, p2[0], p2[1], p2[2], nx, ny, nz, color, alpha, tex_xstart+tex_xrepeat, tex_ystart+tex_yrepeat);
}