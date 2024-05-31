function draw_rectangle_ext(x1, y1, x2, y2, x3, y3, x4, y4) {
	draw_triangle(x1, y1, x2, y2, x3, y3, false);
	draw_triangle(x1, y1, x3, y3, x4, y4, false);
}