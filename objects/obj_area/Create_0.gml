instances = []
neighbors = []
depth = -1
started_building = false
finished_building = false

if (is_undefined(get_is_building)) {
	get_is_building = function() {
		return false;	
	}
}

ts_on_built = time_source_create(time_source_global, 1, time_source_units_frames, function() {
	if (!is_undefined(on_built)) {
		on_built(id)
	}
})

if (!is_undefined(reset)) {
	reset()
}