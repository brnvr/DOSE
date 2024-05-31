function camera_3d_smooth_point_at_direction(camera, yaw, pitch, rate = 0.1) {
	camera.yaw = smooth_angular_interpolation(camera.yaw, yaw, rate);
	camera.pitch = smooth_angular_interpolation(camera.pitch, pitch, rate);
}

