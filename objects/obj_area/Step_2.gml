if (!get_is_building() && started_building) {
	if (!finished_building) {
		if (on_build != undefined) {
			time_source_start(ts_on_build)
		}
		
		finished_building = true
	}
}