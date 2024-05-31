has_been_opened = false;

action = function() {
	if (!locked) {
		var door_number_index;
		
		is_open = !is_open;
		has_been_opened = true;
		
		event_user(0);
		event_user(1);
		if (player_pass_through_auto) event_user(2);
		
		door_number_index = array_find(obj_control.door_number_order, door_number);
		
		if (door_number_index >= 0) {
			array_delete(obj_control.door_number_order, door_number_index, 1);	
		}
	} else {
		obj_hud.show_speech("Locked.", true);	
	}
}

make_chamber = function(dir) {
	var pos, xst, yst, opposite_dir, dest_area;
		
	opposite_dir = cardinal_opposite(dir);
	dest_area = instance_create_3d(0, 0, 0, obj_chamber, {
		callback_build: function(chamber) {
			chamber_populate(chamber, obj_control.seed_group, BLOCK_SIZE_DEFAULT);
		}
	});
	
	chamber_generate(dest_area);
	pos = chamber_add_passage_random(dest_area, opposite_dir);
				
	switch (dir) {
		case cardinal.east:
			xst = x;
			yst = y-DOOR_PASSAGE_SIDE_WIDTH-pos*BLOCK_SIZE_DEFAULT;
			areas.east = dest_area;
			break;
				
		case cardinal.west:
			xst = x-dest_area.hlength*BLOCK_SIZE_DEFAULT;
			yst = y-DOOR_PASSAGE_SIDE_WIDTH-pos*BLOCK_SIZE_DEFAULT;
			areas.west = dest_area;
			break;
				
		case cardinal.south:
			xst = x-DOOR_PASSAGE_SIDE_WIDTH-pos*BLOCK_SIZE_DEFAULT;
			yst = y;
			areas.south = dest_area;
			break;
				
		case cardinal.north:
			xst = x-DOOR_PASSAGE_SIDE_WIDTH-pos*BLOCK_SIZE_DEFAULT;
			yst = y-dest_area.vlength*BLOCK_SIZE_DEFAULT;
			areas.north = dest_area;
			break;
	}
	
	dest_area.x = xst;
	dest_area.y = yst;
		
	chamber_build(dest_area, obj_control.seed_group, BLOCK_SIZE_DEFAULT, DOOR_PASSAGE_SIDE_WIDTH);
	
	return dest_area;
}

make_corridor = function(dir) {
	var dest_area, door_coord, opposite_dir, xst, yst;
	
	opposite_dir = cardinal_opposite(dir);
	
	dest_area = instance_create_3d(0, 0, 0, obj_corridor, {
		callback_build: function(corridor) {
			corridor_populate(corridor, obj_control.seed_group, BLOCK_SIZE_DEFAULT);
		}
	});
	
	corridor_generate(dest_area);
		
	door_coord = corridor_get_door_random(dest_area, opposite_dir);
		
	if (is_undefined(door_coord)) {
		door_coord = corridor_add_passage_random(dest_area, opposite_dir);
	} else {
		corridor_remove_door(dest_area, door_coord[0], door_coord[1], opposite_dir);
	}
		
	switch (dir) {
		case cardinal.east:
			xst = x-door_coord[0]*BLOCK_SIZE_DEFAULT;
			yst = y-DOOR_PASSAGE_SIDE_WIDTH-door_coord[1]*BLOCK_SIZE_DEFAULT;
			areas.east = dest_area;
			break;
			
		case cardinal.west:
			xst = x-(door_coord[0]+1)*BLOCK_SIZE_DEFAULT;
			yst = y-DOOR_PASSAGE_SIDE_WIDTH-door_coord[1]*BLOCK_SIZE_DEFAULT;
			areas.west = dest_area;
			break;
				
		case cardinal.north:
			xst = x-DOOR_PASSAGE_SIDE_WIDTH-door_coord[0]*BLOCK_SIZE_DEFAULT;
			yst = y-(door_coord[1]+1)*BLOCK_SIZE_DEFAULT;
			areas.north = dest_area;
			break;
				
		case cardinal.south:
			xst = x-DOOR_PASSAGE_SIDE_WIDTH-door_coord[0]*BLOCK_SIZE_DEFAULT;
			yst = y-door_coord[1]*BLOCK_SIZE_DEFAULT;
			areas.south = dest_area;
			break;
	}
	
	dest_area.x = xst;
	dest_area.y = yst;
	
	if (door_number < 0) {
		set_door_number(cardinal_opposite(dir));
	}
	
	corridor_build(dest_area, obj_control.seed_group, BLOCK_SIZE_DEFAULT, DOOR_PASSAGE_SIDE_WIDTH);

	return dest_area;
}

texture_list = [sprite_get_texture(sprite_index, 0)];

set_door_number = function(side=undefined) {
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

if (number_side != -1) {
	set_door_number();	
}

event_inherited();

