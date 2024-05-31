function corridor_get_staircase_random(corridor, direction) {
	var arr;
	
	arr = corridor.staircase_coords[direction];
	
	if (array_length(arr) > 0) {
		return array_choose(arr);
	} else {
		return undefined;	
	}
}