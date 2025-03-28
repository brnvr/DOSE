if (door_number != -1) {
	if (has_been_opened) {
		array_push(obj_game_control.door_numbers_passed, door_number);	
	} else {
		array_push(obj_game_control.door_numbers_avaliable, door_number);	
	}
}

obj_player.fail_task(task_types.go_back_one_room, id)
event_inherited()