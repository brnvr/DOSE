function inventory_add_item(item, use_animation = true, index = -1) {
	with (obj_player) {
		draw_set_alpha(1)
	
		var spr = noone
		var item_name = object_get_name(item.object_index)
		var inventory_item = undefined
		var n_items = array_length(inventory)
	
		for (var i = 0; i < n_items; i++) {
			if (inventory[i].object_name == item_name) {
				inventory_item = inventory[i]
				index = i
				break
			}
		}
	
		obj_hud.inventory_temp = []
		
		for (var i = 0; i < n_items; i++) {
			array_push(obj_hud.inventory_temp, struct_duplicate(inventory[i]))
		}
	
		if (is_undefined(inventory_item)) {	
			var spr_w = sprite_get_width(item.sprite_index)
			var spr_h = sprite_get_height(item.sprite_index)
			var spr_held = sprite_part_copy(item.sprite_held == noone ? item.sprite_index : item.sprite_held, 0, 0, 0, spr_w, spr_h, spr_w*.5, spr_h*.5)
		
			if (spr_w == INVENTORY_ITEM_SIZE) {
				spr = sprite_part_copy(item.sprite_index, 0, 0, 0, spr_w, spr_h, spr_w*.5, spr_h*.5)
			} else {
				var scale = INVENTORY_ITEM_SIZE/spr_w
		
				var spr_scaled = sprite_get_scaled(item.sprite_index, scale, scale)
		
				spr = sprite_part_copy(spr_scaled, 0, 0, 0, spr_w * scale, spr_h * scale, spr_w*.5 * scale, spr_h*.5 * scale)
			}
		
			index = index >= 0 ? index : array_length(inventory)
	
			inventory_item = {
				"object_name": item_name,
				"object": item.object_index,
				"number": item.quantity,
				"index": index,
				"name": item.display_name,
				"sprite": spr,
				"sprite_held": spr_held,
				"can_combine": item.can_combine,
				"on_select": item.on_select,
				"on_unselect": item.on_unselect
			}
		
			array_insert(inventory, index, inventory_item)
		} else {
			inventory_item.number += item.quantity
		}
	
		if (use_animation) {
			obj_hud.set_item_picked(index, inventory_item.sprite, item.display_name)	
		} else {
			obj_hud.inventory_temp = inventory
		}
	
		return inventory_item	
	}
}