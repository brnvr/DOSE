function draw_text_background_ext_transformed(xx, yy, str, sep, w, xscale, yscale, bg_color, bg_alpha, padding) {
	var str_width, str_height, previous_color, previous_alpha, rec_x0, rec_x1, rec_y0, rec_y1;
	
	str_width = string_width_ext(str, sep, w)*xscale;
	str_height = string_height_ext(str, sep, w)*yscale;
	previous_color = draw_get_color();
	previous_alpha = draw_get_alpha();
	
	switch (draw_get_halign()) {
		case fa_left:
			rec_x0 = xx-padding;
			rec_x1 = xx+str_width+padding;
			break;
			
		case fa_center:
			var hwidth;
			
			hwidth = floor(str_width*.5);
			
			rec_x0 = xx-hwidth-padding;
			rec_x1 = xx+hwidth+padding;
			
			break;
			
		case fa_right:
			rec_x0 = xx-str_width-padding;
			rec_x1 = xx+padding;
			break;
	}
	
	switch (draw_get_valign()) {
		case fa_top:
			rec_y0 = yy-padding;
			rec_y1 = yy+str_height+padding;
			break;
			
		case fa_middle:
			var hheight;
			
			hheight = floor(str_height*.5);
			
			rec_y0 = yy-hheight-padding;
			rec_y1 = yy+hheight+padding;
			
			break;
			
		case fa_bottom:
			rec_y0 = yy-str_height-padding;
			rec_y1 = yy+padding;
			break;
	}
	
	draw_set_color(bg_color);
	draw_set_alpha(bg_alpha);
	draw_rectangle(rec_x0, rec_y0, rec_x1, rec_y1, false);
	draw_set_color(previous_color);
	draw_set_alpha(previous_alpha);
	
	draw_text_ext_transformed(xx, yy, str, sep, w, xscale, yscale, 0);
}