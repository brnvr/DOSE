function door_number_create_sprite(number, font, color, texture_width, texture_height, door_height, number_distance_from_top=65) {
	var surf, sprite, halign_previous, valign_previous, color_previous, font_previous;
	
	halign_previous = draw_get_halign();
	valign_previous = draw_get_valign();
	color_previous = draw_get_color();
	font_previous = draw_get_font();
	surf = surface_create(texture_width, texture_height);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_color(color);
	draw_set_font(font);
	
	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	draw_text_shadow_ext_transformed(texture_width*.5, (texture_height-door_height)+number_distance_from_top,
	string_pad_left(string(number), "0", 3), 0, -1, 1, 1, c_black, .85, 1, 1);
	surface_reset_target();
	
	sprite = sprite_create_from_surface(surf, 0, 0, texture_width, texture_height, false, false, 0, 0);
	
	draw_set_color(color_previous);
	draw_set_valign(valign_previous);
	draw_set_halign(halign_previous);
	draw_set_font(font_previous);
	surface_free(surf);
	
	return sprite;
}