if (room != room_init) {
	bbox_list = bbox_list ?? []

	if (array_length(bbox_list) == 0) {
		bbox_list = [bbox_create(-16/xscale, -16/yscale, -height/zscale, 16/xscale, 16/yscale, 0)];
	}

	if (unique) {
		seed_group_remove(all, sg.items, object_index)
	}	
}

event_inherited()