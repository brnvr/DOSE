function door_change_number(door, number) {
	return door_change_number_index(door, array_find(obj_control.door_numbers_avaliable, number));
}