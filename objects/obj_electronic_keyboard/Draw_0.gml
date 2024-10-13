if (countdown > 0 && view_current = views.view_2d) {
	draw_set_font(font_dark_dream)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_set_alpha(1)
	draw_set_color(c_blanched_almond)
	draw_text_transformed(0, -30, countdown, countdown_scale, countdown_scale, 0)	
}

event_inherited();

