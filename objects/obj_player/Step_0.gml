is_moving = false

if (can_move)							event_user(player_events.moving)
if (can_look)							event_user(player_events.looking)
if (can_interact)						event_user(player_events.interaction)
										event_user(player_events.inventory)
										event_user(player_events.focusing)
										event_user(player_events.auto_move)
										event_user(player_events.standing_up)
if (use_collision_overflow_correction)	event_user(player_events.collision_overflow_correction)

if (stop_focusing_auto && focus != noone) {
	if (camera_3d_is_pointing_at(camera, focus.x, focus.y, focus.z-focus.height*.75)) {
		focus = noone
		can_look = true
		can_move = true
		can_interact = true
	}
}

if (envenoming > 0) {
	var lethal_envenomation = envenoming > MAX_NON_LETHAL_ENVENOMING

	if (!lethal_envenomation) {
		if (envenoming_fade.alpha > envenoming) {
			heal_from_envenomation()
		}
	}	
}

if (is_resetting_stamina) {
	stamina = min(stamina - stamina/100, 1)
	
	if (stamina <= 1) {
		is_resetting_stamina = false
	}
}