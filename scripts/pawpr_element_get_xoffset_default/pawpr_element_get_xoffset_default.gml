function pawpr_element_get_xoffset_default(element) {		
	if (is_undefined(element[pawpr_attr.parent])) return 0;
	
	var parent_direction, parent_align, parent_padding, parent_padding_left, parent_padding_right,
		margin, margin_left, xoffset;
	
	parent_padding = pawpr_element_get_style(element[pawpr_attr.parent], pawpr.padding, 0);
	parent_padding_left = pawpr_element_get_style(element[pawpr_attr.parent], pawpr.padding_left, parent_padding);
	parent_padding_right = pawpr_element_get_style(element[pawpr_attr.parent], pawpr.padding_right, parent_padding);
	parent_direction = pawpr_element_get_style(element[pawpr_attr.parent], pawpr.direction, pawpr_direction.row);
	parent_align = pawpr_element_get_style(element[pawpr_attr.parent], pawpr.align, pawpr_align.at_start);
	margin = pawpr_element_get_style(element, pawpr.margin, 0);
	margin_left = pawpr_element_get_style(element, pawpr.margin_left, margin);
	xoffset = pawpr_element_get_style(element, pawpr.xoffset, 0);
	
	switch (parent_direction) {
		case pawpr_direction.row:
			if (is_undefined(element[pawpr_attr.previous])) {
				return element[pawpr_attr.parent][pawpr_attr.xoffset]+parent_padding_left+margin_left+xoffset;
			} else {
				var previous_margin, previous_margin_right;
				
				previous_margin = pawpr_element_get_style(element[pawpr_attr.previous], pawpr.margin, 0);
				previous_margin_right = pawpr_element_get_style(element[pawpr_attr.previous], pawpr.margin_right, previous_margin);
				
				return element[pawpr_attr.previous][pawpr_attr.xoffset]+element[pawpr_attr.previous][pawpr_attr.width]+previous_margin_right+margin_left+xoffset;	
			}
			
		case pawpr_direction.column:
			switch (parent_align) {
				case pawpr_align.at_start:
					return element[pawpr_attr.parent][pawpr_attr.xoffset]+parent_padding_left+margin_left+xoffset;
					
				case pawpr_align.at_center:
					return element[pawpr_attr.parent][pawpr_attr.xoffset]+(element[pawpr_attr.parent][pawpr_attr.width]-element[pawpr_attr.width])/2+xoffset;
					
				case pawpr_align.at_end:
					var margin_right;
					
					margin_right = pawpr_element_get_style(element, pawpr.margin_right, margin);
					
					return element[pawpr_attr.parent][pawpr_attr.xoffset]+element[pawpr_attr.parent][pawpr_attr.width]-parent_padding_right-element[pawpr_attr.width]-margin_right+xoffset;
					
				default:
					throw "Invalid element alignment";
			}
			
		default:
			throw "Invalid element direction";
	}
}