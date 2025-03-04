draw_set_font(font_dark_dream)
draw_set_color(c_white)
draw_set_alpha(1)

draw_set_color(c_black)
draw_set_alpha(1)
draw_rectangle(global.screen_width-89, 0, global.screen_width, global.screen_height, false)

if (display_overlay_0) {
	draw_overlay()
}

shader_set_2d(0.75)

if (display_inventory && array_length(inventory_temp) > 0) {
	draw_set_font(font_dark_dream)
	draw_set_color(c_white)
	draw_set_alpha(1)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	
	var n_items = array_length(inventory_temp)
	var index = obj_player.inventory_item_selected_index
	var index_next = index == n_items-1 ? 0 : index+1
	var index_previous = index == 0 ? n_items-1 : index-1
	
	if (index >= 0) {
		var xpos = INVENTORY_CENTER_X
		var ypos = INVENTORY_CENTER_Y
		
		var scale = inventory_item_selected_scale
			
		draw_inventory_item(xpos, ypos, index, true, scale)
			
		if (n_items == 2) {
			index_previous = index_next
		}
		
		if (n_items >= 2) {
			draw_inventory_item(xpos, ypos + INVENTORY_ITEM_SIZE, index_next, false, .5)
			draw_inventory_item(xpos, ypos - INVENTORY_ITEM_SIZE, index_previous, false, .5)
		}
		
		shader_set_2d(0.75)
	}	
}

draw_sprite(hud_panel, 0, 0, 0)

if (eyes != noone) {
	draw_sprite_ext(eyes.sprite_index, eyes.image_index, eyes.x, eyes.y, 1, 1, 0, c_white, 1)
}

if (skull != noone) {
	draw_sprite_ext(skull.sprite_index, skull.image_index, skull.x, skull.y, 1, 1, 0, c_white, 1)
}

if (display_fog) {
	var scissor = gpu_get_scissor()
	
	gpu_set_scissor((skull.x-32)*3, (skull.y-48)*3, 64*3, 96*3)
	gpu_set_blendmode_ext(bm_dest_color, bm_zero)
	draw_sprite_ext(obj_fog_overlay.sprite_index, obj_fog_overlay.image_index, skull.x - 200, skull.y - 225, 2, 2, 0, c_white, 1)
	gpu_set_scissor(scissor)
	gpu_set_blendmode(bm_normal)	
}

if (display_inventory) {
	if (inventory_button_up_selected) {
		draw_sprite(spr_inventory_button_selected, 2, INVENTORY_CENTER_X, 37)
	} else {
		draw_sprite(spr_inventory_button_selected, 0, INVENTORY_CENTER_X, 37)
	}
	
	if (inventory_button_down_selected) {
		draw_sprite(spr_inventory_button_selected, 3, INVENTORY_CENTER_X, 191)
	} else {
		draw_sprite(spr_inventory_button_selected, 1, INVENTORY_CENTER_X, 191)
	}
}

if (item_picked != noone) {
	draw_sprite_ext(item_picked.sprite, 0, item_picked.x, item_picked.y, item_picked.scale, item_picked.scale, 0, c_white, 1)
}

if (display_caption) {
	if (caption != "") {
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
	
		draw_set_color(c_white);
		draw_set_alpha(1);
		draw_text_ext_transformed(game_view_center_x, global.screen_height-43, caption, 16, 500, .75, .75, 0);
		draw_text_transformed(game_view_center_x, global.screen_height-29, subcaption, .5, .5, 0)
	} else if (obj_player.can_interact) {
		if (obj_player.actor_hover != noone && instance_exists(obj_player.actor_hover)) {
			var msg = ""
			var action = ""
		
			if (obj_player.inventory_item_selected != noone) {
				if (obj_player.inventory_item_selected.can_combine) {
						if (object_is_ancestor(obj_player.actor_hover.object_index, obj_npc_generic)) {
						msg = $"give {obj_player.inventory_item_selected.name} to {obj_player.actor_hover.name}"
					} else {
						msg = $"use {obj_player.inventory_item_selected.name} with {obj_player.actor_hover.name}"
					}	
				}
			} else {
				msg = obj_player.actor_hover.name
				action = obj_player.actor_hover.action_description
			}

			draw_set_halign(fa_center)
			draw_set_valign(fa_top)
		
			draw_set_color(c_white)
			draw_set_alpha(1)
			draw_text_ext_transformed(game_view_center_x, global.screen_height-43, msg, 16, 500, .75, .75, 0)
			draw_text_transformed(game_view_center_x, global.screen_height-29, action, .5, .5, 0)
		}
	}	
}

var n_notifications = instance_number(obj_notification)
var last_notification = n_notifications > 0 ? instance_find(obj_notification, n_notifications-1) : noone
var notifications_yoffset = last_notification == noone ? 0 : last_notification.x - last_notification.xstart

for (var i = 0; i < n_notifications; i++) {
	var notification = instance_find(obj_notification, i)
	var yoffset = notification == last_notification ? 0 : notifications_yoffset
	
	shader_reset()
	draw_set_color(notification.color)
	draw_set_halign(fa_right)
	draw_set_valign(fa_top)
	draw_set_alpha(notification.alpha)
	pawpr_draw_text_ext_transformed_shadow(notification.x, notification.y + (n_notifications-1-i)*13 - yoffset, notification.text, 0, 1000, .5, .5, 0, c_black, 1, 1, 1)
	draw_set_alpha(1)	
}

if (display_overlay_1) {
	draw_overlay()
}

draw_set_alpha(1)
draw_set_color(c_white)
shader_reset()