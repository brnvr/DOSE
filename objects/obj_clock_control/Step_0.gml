if (instance_exists(obj_wallclock)) {
	var new_seconds_angle = pi / 30 * current_second;
	var changed = new_seconds_angle != seconds_angle;	

	if (changed) {
		seconds_angle = new_seconds_angle;
		minutes_angle = (pi / 30) * current_minute + (pi / 1800) * current_second;
	    hours_angle = (pi / 6) * (current_hour % 12) + (pi / 360) * current_minute + (pi / 21600) * current_second;
	}
}

