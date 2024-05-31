draw_set_font(font_dark_dream);
draw_set_color(c_white);
draw_set_alpha(1);

draw_set_color(c_black);
draw_set_alpha(1);
draw_rectangle(screen_width-89, 0, screen_width, screen_height, false);

if (display_overlay_0) {
	draw_overlay();
}

shader_set_ui(obj_control.saturation, 5);

if (display_inventory && array_length(inventory_temp) > 0) {
	draw_set_font(font_dark_dream);
	draw_set_color(c_white);
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	var n_items, index, index_next, index_previous;
	
	n_items = array_length(inventory_temp);
	index = obj_player.inventory_item_selected_index;
	index_next = index == n_items-1 ? 0 : index+1;
	index_previous = index == 0 ? n_items-1 : index-1;
	
	if (index >= 0) {
		var xpos, ypos, scale, saturation;
		
		xpos = INVENTORY_CENTER_X;
		ypos = INVENTORY_CENTER_Y;
		
		scale = inventory_item_selected_scale;
		saturation = obj_player.inventory_item_selected == noone ? obj_control.saturation : obj_control.saturation *.25;
			
		draw_inventory_item(xpos, ypos, index, true, scale, saturation);
			
		if (n_items == 2) {
			index_previous = index_next;
		}
		
		if (n_items >= 2) {
			draw_inventory_item(xpos, ypos + INVENTORY_ITEM_SIZE, index_next, false, .5, obj_control.saturation*.5, 2);
			draw_inventory_item(xpos, ypos - INVENTORY_ITEM_SIZE, index_previous, false, .5, obj_control.saturation*.5, 2);
		}
	}	
}

shader_set_ui(obj_control.saturation, 7);

draw_sprite(hud_panel, 0, 0, 0);

shader_set_ui(obj_control.saturation, 3);

if (instance_exists(obj_eyes)) {
	draw_sprite_ext(eyes.sprite_index, eyes.image_index, eyes.x, eyes.y, 1, 1, 0, c_white, 1);
}

shader_set_ui(obj_control.saturation, 7);

if (display_inventory) {
	if (inventory_button_up_selected) {
		draw_sprite(spr_inventory_button_selected, 2, INVENTORY_CENTER_X, 37);
	} else {
		draw_sprite(spr_inventory_button_selected, 0, INVENTORY_CENTER_X, 37);
	}
	
	if (inventory_button_down_selected) {
		draw_sprite(spr_inventory_button_selected, 3, INVENTORY_CENTER_X, 191);	
	} else {
		draw_sprite(spr_inventory_button_selected, 1, INVENTORY_CENTER_X, 191);
	}
}

shader_set_ui(obj_control.saturation, 5);

if (item_picked != noone) {
	draw_sprite_ext(item_picked.sprite, 0, item_picked.x, item_picked.y, item_picked.scale, item_picked.scale, 0, c_white, 1);
}

shader_set_ui(obj_control.saturation, 7);

if (speech != "") {
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	
	draw_set_color(c_white);
	draw_set_alpha(1);
	draw_text_ext_transformed(game_view_center_x, screen_height-43, speech, 16, 500, .75, .75, 0);
} else if (obj_player.can_interact) {
	if (obj_player.actor_hover != noone && instance_exists(obj_player.actor_hover)) {
		var msg, action;
		
		if (obj_player.inventory_item_selected != noone) {
			if (object_is_ancestor(obj_player.actor_hover.object_index, obj_npc_generic)) {
				msg = $"give {obj_player.inventory_item_selected.name} to {obj_player.actor_hover.name}";
			} else {
				msg = $"use {obj_player.inventory_item_selected.name} with {obj_player.actor_hover.name}";
			}
			
			action = "";
		} else {
			msg = obj_player.actor_hover.name;
			action = obj_player.actor_hover.action_description;
		}

		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		
		draw_set_color(c_white);
		draw_set_alpha(1);
		draw_text_ext_transformed(game_view_center_x, screen_height-43, msg, 16, 500, .75, .75, 0);
		
		draw_set_color(c_yellow);
		draw_set_alpha(.5);
		draw_text_transformed(game_view_center_x, screen_height-29, action, .5, .5, 0);
		draw_set_alpha(1);
	}
}

shader_reset();

for (var i = 0; i < instance_number(obj_hud_message); i++) {
	var obj_message;
	
	obj_message = instance_find(obj_hud_message, i);
	
	draw_set_color(obj_message.color)
	draw_set_halign(fa_right)
	draw_set_valign(fa_top)
	draw_set_alpha(obj_message.alpha)
	draw_text_transformed(obj_message.x, obj_message.y + i*13, obj_message.message, .5, .5, 0)
	draw_set_alpha(1)
}

if (display_overlay_1) {
	draw_overlay();
}

draw_set_alpha(1)
draw_set_color(c_white)