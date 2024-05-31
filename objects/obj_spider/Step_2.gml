if (!is_undefined(path)) {
	sp_find_path_instance_loop(path, id, obj_player, 20, 0);
	sp_follow_path(path, 4);
}

event_inherited();

