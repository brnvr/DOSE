if (!draw_as_gui && view_current == views.view_2d) {
	if (sprite_index != -1) {
		shader_set_ui(enabled ? obj_control.saturation*1.25 : obj_control.saturation*.5, 32);
		draw_sprite_ext(sprite_index, image_index, global.cursor_x+xoffset-(game_view_center_x), global.cursor_y+yoffset-(game_view_center_y), scale, scale, rotation, c_white, alpha);
		shader_reset();
	}	
}