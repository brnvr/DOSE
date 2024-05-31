function pawpr_element_get_yoffset_default(element) {
	if (is_undefined(element[pawpr_attr.parent])) return 0;
	
	var parent_direction, parent_align, parent_padding, parent_padding_top, parent_padding_bottom,
		margin, margin_top, yoffset;
	
	parent_padding = pawpr_element_get_style(element[pawpr_attr.parent], pawpr.padding, 0);
	parent_padding_top = pawpr_element_get_style(element[pawpr_attr.parent], pawpr.padding_right, parent_padding);
	parent_padding_bottom = pawpr_element_get_style(element[pawpr_attr.parent], pawpr.padding_bottom, parent_padding);
	parent_direction = pawpr_element_get_style(element[pawpr_attr.parent], pawpr.direction, pawpr_direction.row);
	parent_align = pawpr_element_get_style(element[pawpr_attr.parent], pawpr.align, pawpr_align.at_start);
	margin = pawpr_element_get_style(element, pawpr.margin, 0);
	margin_top = pawpr_element_get_style(element, pawpr.margin_top, margin);
	yoffset = pawpr_element_get_style(element, pawpr.yoffset, 0);
	
	switch (parent_direction) {
		case pawpr_direction.column:
			if (is_undefined(element[pawpr_attr.previous])) {
				return element[pawpr_attr.parent][pawpr_attr.yoffset]+parent_padding_top+margin_top+yoffset;
			} else {
				var previous_margin, previous_margin_bottom;
				
				previous_margin = pawpr_element_get_style(element[pawpr_attr.previous], pawpr.margin, 0);
				previous_margin_bottom = pawpr_element_get_style(element[pawpr_attr.previous], pawpr.margin_bottom, previous_margin);
	
				return element[pawpr_attr.previous][pawpr_attr.yoffset]+element[pawpr_attr.previous][pawpr_attr.height]+previous_margin_bottom+margin_top+yoffset;	
			}
			
		case pawpr_direction.row:
			switch (parent_align) {
				case pawpr_align.at_start:
					return element[pawpr_attr.parent][pawpr_attr.yoffset]+parent_padding_top+margin_top+yoffset;
					
				case pawpr_align.at_center:
					return element[pawpr_attr.parent][pawpr_attr.yoffset]+(element[pawpr_attr.parent][pawpr_attr.height]-element[pawpr_attr.height])/2+yoffset;
					
				case pawpr_align.at_end:
					var margin_bottom;
					
					margin_bottom = pawpr_element_get_style(element, pawpr.margin_bottom, margin);
					
					return element[pawpr_attr.parent][pawpr_attr.yoffset]+element[pawpr_attr.parent][pawpr_attr.height]-parent_padding_bottom-element[pawpr_attr.height]-margin_bottom+yoffset;
					
				default:
					throw "Invalid element alignment";
			}
			
		default:
			throw "Invalid element direction";
	}
}