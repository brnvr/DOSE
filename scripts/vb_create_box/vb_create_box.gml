function vb_create_box(x0, y0, z0, x1, y1, z1, color, alpha, tex_xstart, tex_ystart, tex_xrepeat, tex_yrepeat, format, xquad=true, yquad=true, zquad=true) {
	var box;
	
	box = vertex_create_buffer();
	
	vertex_begin(box, format);
	
	if (yquad) {
		vb_add_quad(box, [x1, y0, z0], [x0, y0, z0], [x0, y0, z1], [x1, y0, z1], 0, -1, 0, color, alpha, tex_xstart, tex_ystart, tex_xrepeat, tex_yrepeat);
		vb_add_quad(box, [x0, y1, z0], [x1, y1, z0], [x1, y1, z1], [x0, y1, z1], 0, 1, 0, color, alpha, tex_xstart, tex_ystart, tex_xrepeat, tex_yrepeat);
	}
	
	if (xquad) {
		vb_add_quad(box, [x0, y0, z0], [x0, y1, z0], [x0, y1, z1], [x0, y0, z1], -1, 0, 0, color, alpha, tex_xstart, tex_ystart, tex_xrepeat, tex_yrepeat);
		vb_add_quad(box, [x1, y1, z0], [x1, y0, z0], [x1, y0, z1], [x1, y1, z1], 1, 0, 0, color, alpha, tex_xstart, tex_ystart, tex_xrepeat, tex_yrepeat);
	}
	
	if (zquad) {
		vb_add_quad(box, [x0, y0, z0], [x1, y0, z0], [x1, y1, z0], [x0, y1, z0], 0, 0, -1, color, alpha, tex_xstart, tex_ystart, tex_xrepeat, tex_yrepeat);
		vb_add_quad(box, [x1, y0, z1], [x0, y0, z1], [x0, y1, z1], [x1, y1, z1], 0, 0, 1, color, alpha, tex_xstart, tex_ystart, tex_xrepeat, tex_yrepeat);
	}
	
	vertex_end(box);
	vertex_freeze(box);
	return box;
}