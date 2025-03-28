function TimedInterpolator(_initial_value, _final_value, _total_time_seconds, _active = true) : BaseInterpolator(_initial_value, _final_value, _active) constructor {
	initial_value = _initial_value
	total_time_seconds = _total_time_seconds
	
	step = function(on_complete = do_nothing, deactivate_when_completed = true) {
		if (active) {
			value = linear_timed_interpolation(
				initial_value, 
				final_value, 
				value,
				total_time_seconds
			)	
		}
		
		if (has_completed()) {
			on_complete()
			
			if (deactivate_when_completed) {
				stop()
			}
		}
		
		return value
	}
}