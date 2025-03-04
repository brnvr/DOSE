depth = obj_hud.depth

ts_blink = time_source_create(time_source_global, 1, time_source_units_frames, function() { })
ts_set_visibility = time_source_create(time_source_global, 1, time_source_units_frames, function() {
	visible = false	
})

blink = function() {
	time_source_reconfigure(ts_blink, irandom(19), time_source_units_frames, function() {
		visible = true
		blink()
		time_source_start(ts_set_visibility)
	})
	
	time_source_start(ts_blink)
}

blink()