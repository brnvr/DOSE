if (catched_player) {
	if (view_current == views.view_2d) {
		gpu_set_ztestenable(false);
		shader_set_2d();
		draw_sprite_ext(spr_waiter, image_index, 0, 630, 5, 5, 0, c_white, 1);
		shader_reset();
		gpu_set_ztestenable(true);
	}
} else {
	event_inherited();
}