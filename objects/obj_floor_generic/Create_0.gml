texture_list = texture_list ?? []

if (array_length(texture_list) == 0) {
	texture_list = [sprite_get_texture(sprite_index, 0)];	
}

event_inherited();

