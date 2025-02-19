bbox_list = bbox_list ?? []

if (array_length(bbox_list) == 0) {
	bbox_list = [bbox_create(-32/xscale, -32/yscale, -height/zscale, 32/xscale, 32/yscale, 0)];
}

event_inherited();

