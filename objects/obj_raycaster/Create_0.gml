__instance_collided__ = noone;
__iteration__ = 0;
__is_started__ = false;

__update__ = function() {
	x = x_func();
	y = y_func();
	z = z_func();
	pitch = pitch_func();
	yaw = yaw_func();	
}

__raycast__ = function() {
	var ii, reps, targets_surrounding, obstacles_surrounding, n_obstacles, n_targets;
	
	ii = noone;
	reps = max_distance/jump;
	targets_surrounding = [];
	obstacles_surrounding = [];

	with (target) {
		if (point_distance_3d(x, y, z, other.x, other.y, other.z) < other.max_distance*1.5) {	
			array_push(targets_surrounding, id);
		}
	}
	
	for (var i = 0; i < array_length(obstacles); i++) {
		var obstacle;
		
		obstacle = obstacles[i];
		
		with(obstacle) {
			if (collidable) {
				if (point_distance_3d(x, y, z, other.x, other.y, other.z) < other.max_distance*1.5) {
					array_push(obstacles_surrounding, id);	
				}
			}
		}
	}
	
	n_obstacles = array_length(obstacles_surrounding);
	n_targets = array_length(targets_surrounding);
	
	repeat (max_loops_per_step) {
		__iteration__++;
		
		if (__iteration__ > reps) {	
			raycaster_clear(id);
			return;
		}
		
		x += jump*dcos(yaw)*dcos(pitch);
		y -= jump*dsin(yaw)*dcos(pitch);
		z -= jump*dsin(pitch);
		
		for (var i = 0; i < n_obstacles; i++) {
			var inst;
			
			inst = obstacles_surrounding[i];
			
			ii = actor_3d_position(x, y, z, inst);
			
			if (ii != noone) {
				raycaster_clear(id);
				return;
			}
		}
		
		for (var i = 0; i < n_targets; i++) {
			var inst;
			
			inst = targets_surrounding[i];
			
			ii = actor_3d_position(x, y, z, inst, false);
		
			if (ii != noone && ii.active) {
				__instance_collided__ = ii;
				__iteration__ = 0;
				return;
			}
		}
	}
}


__update__();