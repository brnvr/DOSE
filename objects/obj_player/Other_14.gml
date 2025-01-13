/// @description focusing

if (focus != noone) {
	camera_3d_smooth_point_at(camera, focus.x, focus.y, focus.z-focus.height*.6);
}

/*if (point_distance(x, y, focus.x, focus.y) < SIGHT_RANGE-3) {
	var dir, dirsin, dircos;
		
	dir = point_direction(x, y, focus.x, focus.y);
	dirsin = dsin(dir);
	dircos = dcos(dir);
		
	if (!place_meeting_3d(x, y+dirsin, z, obj_actor_3d_generic)) y+=dirsin;
	if (!place_meeting_3d(x-dircos, y, z, obj_actor_3d_generic)) x-=dircos;
}*/