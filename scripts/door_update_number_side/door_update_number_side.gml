function door_update_number_side(){
	if (door_number != -1) {
		switch (number_side) {
			case cardinal.north:
				vbuff_list[1] = obj_player.y > y ? vbuff_list[0] : noone;
				break;
			
			case cardinal.south:
				vbuff_list[1] = obj_player.y < y ? vbuff_list[0] : noone;
				break;
			
			case cardinal.east:
				vbuff_list[1] = obj_player.x < x ? vbuff_list[0] : noone;
				break;
			
			case cardinal.west:
				vbuff_list[1] = obj_player.x > x ? vbuff_list[0] : noone;
				break;
		}
	}
}