function string_get_sprite(text, font, color) {
	var surf, sprite, halign_previous, valign_previous, color_previous, font_previous, width, height;
	
	halign_previous = draw_get_halign();
	valign_previous = draw_get_valign();
	color_previous = draw_get_color();
	font_previous = draw_get_font();
	width = string_width(text);
	height = string_height(text);
	surf = surface_create(width, height);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(color);
	draw_set_font(font);
	
	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	draw_text(0, 0, text);
	surface_reset_target();
	
	sprite = sprite_create_from_surface(surf, 0, 0, width, height, false, false, 0, 0);
	
	draw_set_color(color_previous);
	draw_set_valign(valign_previous);
	draw_set_halign(halign_previous);
	draw_set_font(font_previous);
	surface_free(surf);
	
	return sprite;
}