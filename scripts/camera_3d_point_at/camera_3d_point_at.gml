function camera_3d_point_at(camera, xdest, ydest, zdest, spd) {
	var xydist, zdist, pitch_direction, yaw_direction;
	
	xydist = point_distance(camera.x, camera.y, xdest, ydest);
	zdist = camera.z-zdest;
	
	pitch_direction = darctan(zdist/xydist);
	yaw_direction = point_direction(camera.x, camera.y, xdest, ydest);
	
	camera.yaw = angular_interpolation(camera.yaw, yaw_direction, spd);
	camera.pitch = angular_interpolation(camera.pitch, pitch_direction, spd);
}

