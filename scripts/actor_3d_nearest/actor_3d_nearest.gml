function actor_3d_nearest(xpos, ypos, zpos, obj, predicate = undefined) {
	var nearest_instance, smallest_distance;
	
	nearest_instance = undefined;
	smallest_distance = -1;
	
	with(obj) {
		var dist = sqrt(sqr(x-xpos) + sqr(y-ypos) + sqr(z-zpos))
		
		if (smallest_distance == -1 || dist < smallest_distance) {
			if (is_undefined(predicate) || predicate(id, other, dist)) {
				nearest_instance = id;
				smallest_distance = dist;
			}
		}
	}
	
	return nearest_instance;
}