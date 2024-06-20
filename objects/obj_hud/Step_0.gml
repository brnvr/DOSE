display_overlay_0 = false
display_overlay_1 = false;

if (item_picked != noone) {
	var item_picked_new_position, x_dest, y_dest, limit;
	
	x_dest = INVENTORY_CENTER_X + sprite_get_draw_center_x(item_picked.sprite);
	y_dest = INVENTORY_CENTER_Y + sprite_get_draw_center_y(item_picked.sprite);
	
	item_picked_new_position = vector_move_point([item_picked.x, item_picked.y], [x_dest, y_dest], ITEM_PICKED_SPEED);
	
	item_picked.x = item_picked_new_position[0];
	item_picked.y = item_picked_new_position[1];
	
	limit = ITEM_PICKED_SPEED+(array_length(obj_player.inventory) == 1 ? 0 : 25);
	
	if (point_distance(item_picked.x, item_picked.y, x_dest, y_dest) <= limit) {
		obj_player.receive_item(item_picked)
		item_picked = noone
	}
}

if (inventory_item_selected_scale > 1) {
	inventory_item_selected_scale = linear_interpolation(inventory_item_selected_scale, 1, 0.05);	
}

if (speech != "" && audio_is_playing(obj_espeak_control.audio_buffer)) {
	is_speaking = true;
}

if (is_speaking && !audio_is_playing(obj_espeak_control.audio_buffer)) {
	is_speaking = false;
	speech = "";
}

if (display_annotations) {
	if (annotations_offset > 0) {
		annotations_offset = smooth_interpolation(annotations_offset, 0);
	}
} else {
	if (annotations_offset <= 40) {
		annotations_offset += 10
	}
}

