function actor_3d_rotate_centered_z(angle, actor=id) {
	var original_center, rotated_center, translation_vector;
	
	original_center = [actor.xscale/2, actor.yscale/2];
	
	rotated_center =	[original_center[0] * dcos(angle) - original_center[1] * dsin(angle),
						 original_center[0] * dsin(angle) - original_center[1] * dcos(angle)];
						 
	translation_vector = [original_center[0] - rotated_center[0], original_center[1] - rotated_center[1]];
	
	actor.zrotation += angle;
	actor.x += translation_vector[0];
	actor.y += translation_vector[1];
}