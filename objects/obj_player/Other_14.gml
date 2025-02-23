/// @description focusing

if (focus != noone) {
	camera_3d_smooth_point_at(camera, focus.x, focus.y, focus.z-focus.height*.6);
}