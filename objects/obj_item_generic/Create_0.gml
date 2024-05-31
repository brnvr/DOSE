if (array_length(bbox_list) == 0) {
	bbox_list = [bbox_create(-16/xscale, -16/yscale, -height/zscale, 16/xscale, 16/yscale, 0)];
}

event_inherited();

