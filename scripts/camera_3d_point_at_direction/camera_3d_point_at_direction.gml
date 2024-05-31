function camera_3d_point_at_direction(camera, yaw, pitch, spd) {
	camera.yaw = angular_interpolation(camera.yaw, yaw, spd);
	camera.pitch = angular_interpolation(camera.pitch, pitch, spd);
}

