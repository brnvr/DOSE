var new_seconds_angle;
	
new_seconds_angle = 6 * current_second;
changed = new_seconds_angle != seconds_angle;	

if (changed) {
	seconds_angle = new_seconds_angle;
	minutes_angle = 6 * current_minute + 0.1 * current_second;
	hours_angle = 30 * (current_hour mod 12) + minutes_angle/12;
}