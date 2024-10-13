if (!get_is_building() && started_building) {
	if (!finished_building) {
		if (on_built != undefined) {
			time_source_start(ts_on_built)
		}
		
		finished_building = true
	}
}