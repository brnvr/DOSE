if (get_is_building()) {
	var args;
	
	args = building_queue[0];
	corridor_build(id, args[0], args[1], args[2]);
	array_shift(building_queue);
}