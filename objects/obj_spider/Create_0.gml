on_ceiling = choose(true, false);

if (on_ceiling) {
	sprite_index = spr_spider_ceiling;
	z += default_block_size;
}

if (object_is_ancestor(obj_control.current_area.object_index, obj_path_area)) {
	obj_control.current_area.begin_pathfinding();
	path = sp_path_create(obj_control.current_area.sp_grid);
} else {
	path = undefined;	
}

event_inherited();

