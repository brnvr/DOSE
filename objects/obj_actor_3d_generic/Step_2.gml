if (billboard) {
	zrotation = obj_player.camera.yaw;

	if (array_length(vbuff_list) == 0) {
		vbuff_list = [vbuff_billboard];
	}
}

if (texture_animated) {
	texture_list = [sprite_get_texture(sprite_index, image_index)];
}	

if (actor_3d_has_transformed()) {
	if (dynamic) {
		actor_3d_update_bbox()
		actor_3d_retrive_previous_properties()
	}
		
	actor_3d_update_transformation_matrix()
}

if (auto_depth) {
	depth = point_distance_3d(x, y, z, obj_player.x, obj_player.y, obj_player.z);
	if (billboard) depth -= 500;
}