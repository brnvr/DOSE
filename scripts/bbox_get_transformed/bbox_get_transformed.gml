function bbox_get_transformed(bbox, matrix) {
	var vec0, vec1, vec2, vec3;
	
	vec0 = matrix_transform_vertex(matrix, bbox[0], bbox[1], bbox[2]);
	vec1 = matrix_transform_vertex(matrix, bbox[3], bbox[4], bbox[5]);
	vec2 = matrix_transform_vertex(matrix, bbox[0], bbox[4], bbox[2]);
	vec3 = matrix_transform_vertex(matrix, bbox[3], bbox[1], bbox[5]);
	
	return [min(vec0[0], vec1[0], vec2[0], vec3[0]),
			min(vec0[1], vec1[1], vec2[1], vec3[1]),
			min(vec0[2], vec1[2], vec2[2], vec3[2]),
			max(vec0[0], vec1[0], vec2[0], vec3[0]),
			max(vec0[1], vec1[1], vec2[1], vec3[1]),
			max(vec0[2], vec1[2], vec2[2], vec3[2])];
}