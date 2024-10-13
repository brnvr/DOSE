function pawpr_element_get_bounding_rect(element) {
	var expansion = pawpr_element_get_style(element, pawpr.expansion, 1, false);
	var bounding_rect = [];
	
	var xoffset = undefined
	var yoffset = undefined
	
	if (expansion != 1) {
		var scale = pawpr_element_get_style(element, pawpr.scale, 1, false);	
		xoffset = element[pawpr_attr.width]*(expansion-scale)*.5;
		yoffset = element[pawpr_attr.height]*(expansion-scale)*.5;
	} else {
		xoffset = 0;
		yoffset = 0;
	}
	
	var xbase = undefined
	var ybase = undefined
	
	switch (element[pawpr_attr.ui][pawpr_attr.horizontal_align]) {
		case pawpr_align.at_center:
			xbase = element[pawpr_attr.ui][pawpr_attr.x]-element[pawpr_attr.ui][pawpr_attr.width]/2;
			break;
			
		case pawpr_align.at_end:
			xbase = element[pawpr_attr.ui][pawpr_attr.x]-element[pawpr_attr.ui][pawpr_attr.width];
			break;
		
		default:
			xbase = element[pawpr_attr.ui][pawpr_attr.x];
			break;
	}
	
	switch (element[pawpr_attr.ui][pawpr_attr.vertical_align]) {
		case pawpr_align.at_center:
			ybase = element[pawpr_attr.ui][pawpr_attr.y]-element[pawpr_attr.ui][pawpr_attr.height]/2;
			break;
			
		case pawpr_align.at_end:
			ybase = element[pawpr_attr.ui][pawpr_attr.y]-element[pawpr_attr.ui][pawpr_attr.height];
			break;
		
		default:
			ybase = element[pawpr_attr.ui][pawpr_attr.y];
			break;
	}
	
	bounding_rect[pawpr_rect.left] = xbase+element[pawpr_attr.xoffset]-xoffset;
	bounding_rect[pawpr_rect.top] = ybase+element[pawpr_attr.yoffset]-yoffset;
	bounding_rect[pawpr_rect.right] = bounding_rect[pawpr_rect.left]+element[pawpr_attr.width]+xoffset;
	bounding_rect[pawpr_rect.bottom] = bounding_rect[pawpr_rect.top]+element[pawpr_attr.height]+yoffset;
	
	return bounding_rect;
}