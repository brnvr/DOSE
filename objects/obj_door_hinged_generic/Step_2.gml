if (opening_direction_auto) {
	if (!is_open && opening == 0) {
		switch (orientation) {
			case alignment.vertical:
				if (obj_player.x > x) {
					opening_direction = angular.clockwise;
				} else {
					opening_direction = angular.counterclockwise;	
				}
			
				break;
	
			case alignment.horizontal:
				if (obj_player.y > y) {
					opening_direction = angular.counterclockwise;
				} else {
					opening_direction = angular.clockwise;	
				}
				
				break;
		}
	}
}

if (is_open) {
	if (opening_direction == angular.counterclockwise) {
		opening = linear_interpolation(opening, max_opening, opening_speed);
	} else {
		opening = linear_interpolation(opening, -max_opening, opening_speed);
	}
} else {
	opening = linear_interpolation(opening, math_get_epsilon(), opening_speed);
}

zrotation = zrotation_start + opening + math_get_epsilon();