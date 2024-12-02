/// @description auto moving

if (is_moving_auto) {
	can_move = false;
	can_look = false;
	can_interact = false;
	obj_cursor.sprite_index = -1;
	
	move(function(offset, move_speed) {
		if (x > move_auto_coord[0]) {
			offset[0] = -move_speed;	
		}
		
		if (x < move_auto_coord[0]) {
			offset[0] = move_speed;	
		}
		
		if (y > move_auto_coord[1]) {
			offset[1] = -move_speed;	
		}
		
		if (y < move_auto_coord[1]) {
			offset[1] = move_speed;	
		}
		
		var xarrived = false;
		var yarrived = false;
		
		if (abs(x-move_auto_coord[0]) < move_speed) {
			x = move_auto_coord[0];
			offset[0] = 0;
			xarrived = true;
		}
		
		if (abs(y-move_auto_coord[1]) < move_speed) {
			y = move_auto_coord[1];
			offset[1] = 0;
			yarrived = true;
		}
		
		if (xarrived && yarrived) {
			cursor_center();
			is_moving_auto = false;
			if (!lock_move) can_move = true;
			if (!lock_look) can_look = true;
			if (!lock_interact) can_interact = true;
			obj_cursor.sprite_index = spr_cursor_point;
			
			if (!is_undefined(on_move_auto)) {
				on_move_auto()	
			}
		}
	}, move_auto_speed);
	
	cursor_center();
}

if (door_passing != noone && !is_moving_auto) {	
	door_passing.is_open = false;
	door_passing = noone;
	//obj_control.door_selected = noone;
}