function door_update_cullmode(){
	if (cullmode != cull_noculling) {
		var current_area;

		current_area = obj_control.current_area;

		switch (orientation) {
			case alignment.vertical:
				if (current_area == areas[cardinal.west]) {
					cullmode = cull_counterclockwise;
				} else {
					cullmode = cull_clockwise;
				}
		
				break;
	
			case alignment.horizontal:
				if (current_area == areas[cardinal.north]) {
					cullmode = cull_clockwise;
				} else {
					cullmode = cull_counterclockwise;
				}
		
				break;
		}	
	}
}