sync_cursor = true;
ts_pause_sync = time_source_create(time_source_global, 1, time_source_units_frames, function() {});
mouse_click_locked = buffer_create(6, buffer_fixed, 1);
global.cursor_x = 0;
global.cursor_y = 0;