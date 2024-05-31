function instance_follow(px, py, spd, block_size=default_block_size) {
	var instance_follow_corridor, instance_follow_room;
	
	instance_follow_room = function(px, py, spd) {
		var vec;
		
		vec = vector_move_point([x, y], [px, py], spd);	
		
		x = vec[0];
		y = vec[1];
	}
	
	instance_follow_corridor = function(corridor, px, py, spd, block_size) {
		var xcurrent_cell, ycurrent_cell, current_cell;
		
		xcurrent_cell = (x-corridor.x) div block_size;
		ycurrent_cell = (y-corridor.y) div block_size;
		current_cell = corridor.cell[# xcurrent_cell, ycurrent_cell];
		
		switch (current_cell.orientation) {
			case alignment.vertical:
				x = linear_interpolation(x, corridor.x + block_size*(xcurrent_cell + .5), spd);
				y = linear_interpolation(y, py, spd);
				break;
			
			case alignment.horizontal:
				x = linear_interpolation(x, px, spd);
				y = linear_interpolation(y, corridor.y + block_size*(ycurrent_cell + .5), spd);
				break;
				
			default:
				
		}
	}
}

/*
	if (!variable_instance_exists(id, "z")) {
		show_error("Instance must be a 3d actor.", true);	
	}
	
	var vector, vec_dist, recalc, vec_normal;
	
	vector = [px-x, py-y, pz-z];
	vec_normal = vector_get_normal(vector);
	
	if (is_undefined(vec_normal)) return;
	
	vec_dist = vector_multiply_by_scalar(vec_normal, spd);
	recalc = false;
	
	if (place_meeting_3d(x+vec_dist[0], y, z, obj_actor_3d_generic)) {
		vector[0] = 0;
		recalc = true;
	} else if (place_meeting_3d(x, y+vec_dist[1], z, obj_actor_3d_generic)) {
		vector[1] = 0;
		recalc = true;
	} else if (place_meeting_3d(x, y, z+vec_dist[2], obj_actor_3d_generic)) {
		vector[2] = 0;
		recalc = true;
	}
	
	if (recalc) {
		vec_dist = vector_multiply_by_scalar(vector_get_normal(vector), spd);
	}
	
	x += vec_dist[0];
	y += vec_dist[1];
	z += vec_dist[2];
*/