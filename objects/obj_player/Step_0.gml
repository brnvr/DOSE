if (can_move)							event_user(player_controls.moving);
if (can_look)							event_user(player_controls.looking);
if (can_interact)						event_user(player_controls.interaction);
										event_user(player_controls.inventory);
										event_user(player_controls.focusing);
										event_user(player_controls.auto_move);
										event_user(player_controls.standing_up);
if (use_collision_overflow_correction)	event_user(player_controls.collision_overflow_correction);

if (stop_focusing_auto && focus != noone) {
	if (camera_3d_is_pointing_at(camera, focus.x, focus.y, focus.z-focus.height+11)) {
		focus = noone
		can_look = true
		can_move = true
		can_interact = true
	}
}