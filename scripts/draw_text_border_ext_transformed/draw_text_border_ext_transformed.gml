function draw_text_border_ext_transformed(xx, yy, str, sep, w, xscale, yscale, border_color) {
	var previous_color = draw_get_color();
		
	draw_set_color(border_color);
	
	for (var j = -1; j <= 1; j++) {
		for (var i = -1; i <= 1; i++) {
			if (i == 0 && j == 0) continue;
			draw_text_ext_transformed(xx+i, yy+j, str, sep, w, xscale, yscale, 0);
		}
	}
	
	draw_set_color(previous_color);
	
	draw_text_ext_transformed(xx, yy, str, sep, w, xscale, yscale, 0);
}