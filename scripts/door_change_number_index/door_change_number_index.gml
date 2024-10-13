function door_change_number_index(door, number_index) {
	var spr_door_number;
	
	if (number_index == door.door_number) return;
	
	array_push(obj_control.door_numbers_avaliable, door.door_number)
	door.door_number = obj_control.door_numbers_avaliable[number_index]
	array_delete(obj_control.door_numbers_avaliable, number_index, 1)
	
	if (door.number_side == cardinal.north || door.number_side == cardinal.east) {
		spr_door_number = global.spr_door_numbers[door.door_number];	
	} else {
		spr_door_number = global.spr_door_numbers_flipped[door.door_number]	
	}
	
	door.texture_list[1] = sprite_get_texture(spr_door_number, 0)
}