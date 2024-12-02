if (is_open) {
	if (!being_used && point_distance_3d(x, y, z, obj_player.x, obj_player.y, obj_player.z) > obj_player.SIGHT_RANGE*1.5) {
		is_open = false;
		event_user(1);
	}
} else {
	door_update_cullmode(id)
}

door_update_number_side(id)

if (opening != 0) {
	cullmode = cull_noculling;	
}

if (player_pass_through_auto) {
	dynamic = false;
	collidable = !is_open;
}

event_inherited();

