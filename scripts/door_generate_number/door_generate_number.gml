function door_generate_number(side=undefined) {
	var spr_door_number;
	
	if (!is_undefined(side)) number_side = side;

	door_number = array_choose(obj_control.door_numbers_avaliable, true);

	if (door_number == -1) {
		throw "dafuq";	
	}

	if (is_undefined(door_number)) {
		if (array_length(obj_control.door_numbers_passed) == 0) {
			throw "Erro maluco";	
		}
		
		door_number = obj_control.door_numbers_passed[0];
		array_delete(obj_control.door_numbers_passed, 0, 1);
	}
	
	if (number_side == cardinal.north || number_side == cardinal.east) {
		spr_door_number = spr_door_numbers[door_number];	
	} else {
		spr_door_number = spr_door_numbers_flipped[door_number]	
	}
	
	array_push(texture_list, sprite_get_texture(spr_door_number, 0));
}