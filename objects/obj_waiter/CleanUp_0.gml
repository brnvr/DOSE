time_source_destroy(ts_set_image);
time_source_destroy(ts_speak);
time_source_destroy(ts_send_to_otherside);
time_source_destroy(ts_process_events);
time_source_destroy(ts_move_to_door);
time_source_destroy(ts_close_door);

if (obj_player.focus == id) {
	obj_player.focus = noone
}

sp_path_delete(path)

event_inherited();