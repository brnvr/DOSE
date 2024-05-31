function corridor_get_door_coords_random(corridor, direction) {
	var arr;
	
	arr = corridor.door_coords[direction];
	
	if (array_length(arr) > 0) {
		return array_choose(arr);
	} else {
		return undefined;	
	}
}