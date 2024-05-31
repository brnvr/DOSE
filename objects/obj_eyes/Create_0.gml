enum eye_actions {
	stare,
	blink,
	look_left,
	look_right,
	look_around
}

chances = array_create_weighted([
	[eye_actions.stare, 2],
	[eye_actions.blink, 9],
	[eye_actions.look_left, 2],
	[eye_actions.look_right, 2],
	[eye_actions.look_around, 1]]
);

sprites = [];
sprites[eye_actions.stare] = spr_eyes_staring;
sprites[eye_actions.look_left] = spr_eyes_looking_left;
sprites[eye_actions.look_right] = spr_eyes_looking_right;
sprites[eye_actions.blink] = spr_eyes_blinking;
sprites[eye_actions.look_around] = spr_eyes_looking_around;

sprite_index = spr_eyes_blinking;
alarm[0] = 13;
image_index = 1;

ts_act = time_source_create(time_source_global, interval, time_source_units_seconds, function() {
	sprite_index = sprites[array_choose(chances)];
	image_index = 0;
	time_source_pause(ts_act);
}, [], -1);