if (array_length(texture_list) == 0) {
	if (passage) {
		bbox_list = [bbox_wall_passage_left, bbox_wall_passage_right];
		vbuff_list = [vb_load("3d models/wall_passage.buf", true)];
	} else {
		texture_list = [sprite_get_texture(sprite_index, image_index)];
	}
}

remap = function(sprite) {
	texture_list[0] = sprite_get_texture(sprite, image_index);
}

event_inherited();