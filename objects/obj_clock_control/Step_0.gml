if (instance_exists(obj_wallclock)) {
	if (obj_game_control.current_realm == realms.thisside) {
		var new_seconds_angle = pi / 30 * current_second
		seconds_changed = new_seconds_angle != seconds_angle

		if (seconds_changed) {
			seconds_angle = new_seconds_angle
			minutes_angle = (pi / 30) * current_minute + (pi / 1800) * current_second
		    hours_angle = (pi / 6) * (current_hour % 12) + (pi / 360) * current_minute + (pi / 21600) * current_second
		}	
	} else {
		seconds_changed = false
		seconds_angle += degtorad(3)
		minutes_angle -= degtorad(5)
		hours_angle += degtorad(7)
	}
}

