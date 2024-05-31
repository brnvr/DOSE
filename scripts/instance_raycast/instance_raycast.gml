function instance_raycast(xx, yy, zz, target, yaw, pitch, maxdist, jump, obstacle_arr = []) {
	var ii, reps, targets_surrounding, obstacles_surrounding, n_obstacles, n_targets;
	 
	ii = noone;
	reps = maxdist/jump;
	targets_surrounding = [];
	obstacles_surrounding = [];

	with (target) {
		if (point_distance_3d(x, y, z, xx, yy, zz) < maxdist*1.5) {	
			array_push(targets_surrounding, id);
		}
	}
	
	for (var i = 0; i < array_length(obstacle_arr); i++) {
		var obstacle;
		
		obstacle = obstacle_arr[i];
		
		with(obstacle) {
			if (collidable) {
				if (point_distance_3d(x, y, z, xx, yy, zz) < maxdist*1.5) {
					array_push(obstacles_surrounding, id);	
				}
			}
		}
	}
	
	n_obstacles = array_length(obstacles_surrounding);
	n_targets = array_length(targets_surrounding);
	
	repeat (reps) {
		xx += jump*dcos(yaw)*dcos(pitch);
		yy -= jump*dsin(yaw)*dcos(pitch);
		zz -= jump*dsin(pitch);
		
		for (var i = 0; i < n_obstacles; i++) {
			var inst;
			
			inst = obstacles_surrounding[i];
			
			ii = actor_3d_position(xx, yy, zz, inst);
			
			if (ii != noone) {
				return noone;	
			}
		}
		
		for (var i = 0; i < n_targets; i++) {
			var inst;
			
			inst = targets_surrounding[i];
			
			ii = actor_3d_position(xx, yy, zz, inst, false);
		
			if (ii != noone && ii.active) {
				return ii;	
			}
		}
	}
	
	return noone;
}