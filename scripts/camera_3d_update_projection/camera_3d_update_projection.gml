function camera_3d_update_projection(camera = id) {
	with (camera) {
		proj_mat = matrix_build_projection_perspective_fov(fov_y, aspect, znear, zfar);
		camera_set_proj_mat(camera.camera, proj_mat)
	}
}