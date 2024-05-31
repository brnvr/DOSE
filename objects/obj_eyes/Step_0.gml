if (sprite_animation_has_finished(sprite_index, image_index, image_speed)) {
	sprite_index = sprites[eye_actions.stare];
	image_index = 0;
	time_source_resume(ts_act);
}