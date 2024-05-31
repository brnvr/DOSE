function vb_add_point(vbuff, xpos, ypos, zpos, nx, ny, nz, color, alpha, u, v) {
	vertex_position_3d(vbuff, xpos, ypos, zpos);
	vertex_normal(vbuff, nx, ny, nz);
	vertex_color(vbuff, color, alpha);
	vertex_texcoord(vbuff, u, v);
}