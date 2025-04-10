if (passage) {
	bbox_list = [global.bbox_wall_passage_left, global.bbox_wall_passage_right];
	vbuff_list = [vb_load("3d_models/wall_passage.buf", true)];
} else {
	texture_list = [sprite_get_texture(sprite_index, image_index)];
	
	if (random_event(prob_generate)) {
		if (choose(0, 1) == 0) {
			array_push(vbuff_list, global.vbuff_wall);
			array_push(texture_list, sprite_get_texture(array_choose(obj_game_control.seed_group[sg.overlays]), 0));
		}
		else {
			var obj = array_choose(obj_game_control.seed_group[sg.wall_props]);
			var inst = area_add_instance(obj_game_control.current_area, x, y, obj);
			
			inst.init_from_wall(id);
		}
	}
}

event_inherited();