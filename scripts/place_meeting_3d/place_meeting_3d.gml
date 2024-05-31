function place_meeting_3d(x, y, z, obj, collidable_only=true) {
	return actor_3d_place(x, y, z, obj, collidable_only) != noone;
}