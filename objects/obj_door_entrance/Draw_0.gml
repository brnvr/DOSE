alpha = .5;
texture_list[0] = sprite_get_texture(spr_door_entrance, 1);
event_inherited();
alpha = 1;
texture_list[0] = sprite_get_texture(spr_door_entrance, 0);
event_inherited();