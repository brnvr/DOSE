/// @description inventory

var inventory_length = array_length(inventory)

if (inventory_item_selected == noone) {
	if (mouse_wheel_down()) {
		if (inventory_length > 1) inventory_item_selected_index = (inventory_item_selected_index+1) mod inventory_length;
		obj_hud.scale_inventory_item_selected();
		obj_hud.inventory_button_down_set_selected();
	}

	if (mouse_wheel_up()) {
		if (inventory_length > 1) inventory_item_selected_index = (inventory_item_selected_index - 1 + inventory_length) mod inventory_length;
		obj_hud.scale_inventory_item_selected();
		obj_hud.inventory_button_up_set_selected();
	}
	
	obj_cursor.rotation = 0;
	cursor_wave.speed = 0;
	cursor_wave.x = 0;
} else {
	cursor_wave.speed = 0.4;
	obj_cursor.rotation = cursor_wave.y;	
	
	var center_y = obj_cursor.sprite_index == noone ? 0 : sprite_get_draw_center_y(obj_cursor.sprite_index, 4);
	var scale_factor = INVENTORY_ITEM_SIZE / sprite_get_width(inventory_item_selected.sprite_held)
	
	if (inventory_item_selected.can_combine) {
		if (actor_hover == noone) {
			obj_cursor.scale = smooth_interpolation(obj_cursor.scale, 4 * scale_factor, 0.2);
			obj_cursor.yoffset = smooth_interpolation(obj_cursor.yoffset, center_y+97, 0.2);
		} else {
			obj_cursor.scale = smooth_interpolation(obj_cursor.scale, 2 * scale_factor, 0.2)
			obj_cursor.yoffset = smooth_interpolation(obj_cursor.yoffset, center_y, 0.2);
		}
	}
}


if (inventory_length > 0 && can_interact) {
	if (inventory_item_selected == noone) {
		mouse_click(mb_right, function() {
			inventory_item_selected = inventory[inventory_item_selected_index];

			inventory_item_selected.on_select()
		})
	} else {
		mouse_click(mb_right, function() {
			inventory_item_selected.on_unselect()
		
			inventory_item_selected = noone		
		})
	}
}

var can_show_annotations = can_interact

if (inventory_item_selected == noone) {
	if (keyboard_check_pressed(vk_space) || mouse_check_button_pressed(mb_any)) {
		if (obj_hud.display_annotations) {
			can_show_annotations = false
			obj_hud.hide_annotations()
			can_interact = true
			obj_cursor.visible = true
		
			cursor_center()
			cursor_pause_sync(1)
		}
	}

	if (keyboard_check_pressed(vk_space)) {
		if (can_show_annotations) {
			obj_hud.show_annotations()
			can_interact = false
			obj_cursor.visible = false
		}	
	}
}