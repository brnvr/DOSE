/// @description standing up

if (is_standing_up) {
	var spd = 3
	var rot = sitting_place.zrotation
	
	if (place_meeting_3d(x, y, z, sitting_place)) {
		x += dsin(rot)*spd
		y += dcos(rot)*spd
	} else {
		is_standing_up = false
		sitting_place = undefined
		can_move = true
		can_interact = true
		use_collision_overflow_correction = true
	}
}	

if (is_undefined(sitting_place) || is_standing_up) {
	eyes_height = linear_interpolation(eyes_height, EYES_HEIGHT_STANDING, 2)	
} else {
	eyes_height = linear_interpolation(eyes_height, EYES_HEIGHT_SITTING, 2)		
}