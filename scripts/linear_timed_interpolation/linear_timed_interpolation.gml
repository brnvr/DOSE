function linear_timed_interpolation(initial_value, final_value, previous_value, total_time_seconds) {
	var time_delta = 1/game_get_speed(gamespeed_fps)
	
	var rate_of_change_per_second = (final_value-initial_value)/total_time_seconds
	
	var elapsed_time = (previous_value - initial_value) / rate_of_change_per_second
	
	var value_delta = rate_of_change_per_second * (elapsed_time + time_delta)
	
	var next_value = initial_value + value_delta
	
	return abs(previous_value-final_value) < abs(next_value-final_value) ? final_value : next_value
}