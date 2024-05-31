function bbox_get_center(bbox, matrix=undefined) {
	var center, _bbox;
	
	_bbox = is_undefined(matrix) ? bbox : bbox_get_transformed(bbox, matrix);
	
	center = [
		mean(_bbox[0], _bbox[3]),
		mean(_bbox[1], _bbox[4]),
		mean(_bbox[2], _bbox[5])
	]
	
	return center;
}