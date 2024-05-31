if (draw_as_gui && sprite_index != -1) {
	shader_set_ui(enabled ? obj_control.saturation*1.25 : obj_control.saturation*.5, 7);
	draw_sprite_ext(sprite_index, image_index, cursor_x+xoffset, cursor_y+yoffset, scale, scale, rotation, c_white, alpha);
	shader_reset();
}