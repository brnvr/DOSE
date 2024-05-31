/// @description Sets door number sprites

spr_door_numbers = [];
spr_door_numbers_flipped = [];

for (var i = 0; i <= 999; i++) {
	array_push(spr_door_numbers, door_number_create_sprite(i, font_dyer, c_blanched_almond,
	default_block_size, default_block_size, 235));
	
	array_push(spr_door_numbers_flipped, sprite_create_transformed(spr_door_numbers[i], -1, 1, 0));
}