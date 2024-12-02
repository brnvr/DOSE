doors = []
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

ts_on_build = time_source_create(time_source_global, 1, time_source_units_frames, function() {
	if (!is_undefined(on_build)) {
		on_build(id)
	}
})

if (!is_undefined(reset)) {
	reset()
}