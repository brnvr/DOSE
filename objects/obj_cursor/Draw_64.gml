if (draw_as_gui && sprite_index != -1) {
	shader_set_2d();
	draw_sprite_ext(sprite_index, image_index, global.cursor_x+xoffset, global.cursor_y+yoffset, scale, scale, rotation, c_white, alpha);
	shader_reset();
}