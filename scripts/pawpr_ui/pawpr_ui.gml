function pawpr_ui(x, y, stylesheet={}, horizontal_align=pawpr_align.at_start, vertical_align=pawpr_align.at_start, template=undefined) {
	if (is_undefined(template)) template = pawpr_template();
	if (!is_struct(template)) throw "Invalid template";
	if (!is_struct(stylesheet)) throw "Invalid stylesheet";
	
	var ui = [];
	ui[pawpr_attr.x] = x;
	ui[pawpr_attr.y] = y;
	ui[pawpr_attr.horizontal_align] = horizontal_align;
	ui[pawpr_attr.vertical_align] = vertical_align;
	ui[pawpr_attr.template] = template;
	ui[pawpr_attr.stylesheet] = stylesheet;
	ui[pawpr_attr.content] = [];
	ui[pawpr_attr.elements] = [];
	ui[pawpr_attr.type] = "container";
	ui[pawpr_attr.parent] = undefined;
	ui[pawpr_attr.previous] = undefined;
	ui[pawpr_attr.xoffset] = 0;
	ui[pawpr_attr.yoffset] = 0;
	ui[pawpr_attr.class] = undefined;
	ui[pawpr_attr.style] = pawpr_class();
	
	return ui;
}

enum pawpr_align {
	at_start,
	at_center,
	at_end
}

enum pawpr_direction {
	row,
	column
}

enum pawpr {
	padding,
	padding_left,
	padding_top,
	padding_right,
	padding_bottom,	
	margin,
	margin_left,
	margin_top,
	margin_right,
	margin_bottom,
	align,
	direction,
	scale,
	color,
	alpha,
	expansion,	
	font,
	line_width,
	line_separation,	
	background_color,
	background_alpha,	
	border_radius,
	border_color,
	border_alpha,
	shadow_xdistance,
	shadow_ydistance,
	shadow_color,
	shadow_alpha,
	image_index,
	image_speed,
	selectors,
	min_width,
	min_height,
	xoffset,
	yoffset
}

enum pawpr_attr {
	type,
	content,
	class,
	style,
	ui,
	parent,
	previous,	
	x,
	y,
	xoffset,
	yoffset,
	width,
	height,
	horizontal_align,
	vertical_align,
	template,
	elements,
	stylesheet,
	events,
	mouse_x,
	mouse_y,
	has_mouse_moved,
	is_mouse_over,
	is_mouse_entering,
	is_mouse_leaving,
	args
}

enum pawpr_rect {
	right,
	top,
	left,
	bottom
}
	
enum pawpr_ev {
	create,
	update,
	mouse_over,
	mouse_out,
	mouse_enter,
	mouse_leave,
	mouse_move
}

enum pawpr_sel {
	hover	
}

enum pawpr_dict {
	key,
	value
}