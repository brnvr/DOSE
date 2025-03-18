function inventory_remove_item(item, unselect = true) {
	with (obj_player) {
		var obj_item = object_get_index(item)
	
		var index = array_find_index(inventory, method({ obj_item: obj_item }, function(inventory_item) {
			return inventory_item.object == obj_item
		}))
	
		if (index == -1) {
			return
		}
	
		var count = inventory[index].number - 1
		var is_selected = inventory_item_selected != noone && inventory_item_selected.object == obj_item
	
		if (inventory[index].number > 1) {
			inventory[index].number--	
		} else {
			if (inventory[index].sprite != inventory[index].sprite_held) {
				sprite_delete(inventory[index].sprite_held)	
			}
		
			sprite_delete(inventory[index].sprite)
		
			array_delete(inventory, index, 1)
		
			if (is_selected && inventory_item_selected_index > 0) {
				inventory_item_selected_index--
			
			}
		}
	
		if (is_selected) {
			obj_cursor.sprite_index = noone
			obj_cursor.draw_as_gui = true
		
			if (unselect) {
				inventory_item_selected = noone
			}
		}
	
		obj_hud.inventory_temp = inventory
	
		return count	
	}
}
