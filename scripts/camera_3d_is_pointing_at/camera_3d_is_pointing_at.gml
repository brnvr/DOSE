function camera_3d_is_pointing_at(camera, xdest, ydest, zdest, angle_limit=5) {
	var xydist, zdist, pitch_direction, yaw_direction;
	
	xydist = point_distance(camera.x, camera.y, xdest, ydest);
	zdist = camera.z-zdest;
	
	pitch_direction = darctan(zdist/xydist);
	yaw_direction = point_direction(camera.x, camera.y, xdest, ydest);

	return
		abs(angle_difference(yaw_direction, camera.yaw)) < angle_limit &&
		abs(angle_difference(pitch_direction, camera.pitch)) < angle_limit;
}