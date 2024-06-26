if (view_current == views.view_2d) {
	draw_set_color(c_black)
	draw_set_alpha(0.25)
	draw_rectangle(-500, -500, 500, 500, false)
	if (array_length(photographs) > 0) {
		draw_set_color(make_color_rgb(220, 220, 220))
		draw_set_alpha(1)
		draw_rectangle(
			-instant_photograph_width*.5-10,
			-instant_photograph_height*.5-25+yoffset,
			instant_photograph_width*.5+10,
			instant_photograph_height*.5+25+yoffset, false)
			
		draw_sprite(photographs[photo_index], 0, 0, -15+yoffset)	
		
		draw_sprite_ext(spr_selection_arrow, 0, arrows_xdist, 0, 1, 1, 0, c_white, arrows_alpha[1])
		draw_sprite_ext(spr_selection_arrow, 0, -arrows_xdist, 0, 1, 1, 180, c_white, arrows_alpha[0])
	}	
}