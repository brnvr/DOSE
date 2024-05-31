if (view_current == views.view_2d) {
	if (sprite_index != -1) {
		gpu_set_ztestenable(false);
		shader_set(sh_overlay);
		draw_sprite_ext(sprite_index, image_index, -sprite_get_width(sprite_index)*2.5, -sprite_get_height(sprite_index)*2.5, 5, 5, 0, c_white, 1);
		shader_reset();
		gpu_set_ztestenable(true);
	}
}
