function actor_3d_retrive_previous_properties() {
	xrotationprevious = xrotation;
	yrotationprevious = yrotation;
	zrotationprevious = zrotation;
	xscaleprevious = xscale;
	yscaleprevious = yscale;
	zscaleprevious = zscale;
	zprevious = z
}

function actor_3d_has_transformed() {
	return (
		xrotationprevious != xrotation ||
		yrotationprevious != yrotation ||
		zrotationprevious != zrotation ||
		xscaleprevious != xscale ||
		yscaleprevious != yscale ||
		zscaleprevious != zscale ||
		xprevious != x ||
		yprevious != y ||
		zprevious != z
	)
}

function actor_3d_update_bbox() {
	array_foreach(bbox_list, function(bbox, i, me) {
		var mat;
		
		if (billboard) {
			mat = matrix_build(0, 0, 0, 0, 0, 0, xscale, yscale, zscale);
		} else {
			mat = matrix_build(0, 0, 0, xrotation, yrotation, zrotation, xscale, yscale, zscale);
		}
		
		me.bbox_transformed_list[i] = bbox_get_transformed(bbox, mat);
	}, id)
}

function actor_3d_update_transformation_matrix() {
	transformation_matrix = matrix_build(x, y, z, xrotation, yrotation, zrotation, xscale, yscale, zscale);		
}