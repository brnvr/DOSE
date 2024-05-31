function cursor_pause_sync(period) {
	with (obj_mouse_control) {
		sync_cursor = false;
	
		time_source_reconfigure(ts_pause_sync, period, time_source_units_frames, function() {
			sync_cursor = true;
		}, [], 1, time_source_expire_after);
	
		time_source_start(ts_pause_sync);
	}
}