function inventory_set_item(item) {
	with (obj_player) {
		item = object_get_index(item)
	
		var inventory_item = inventory_find_item(item)
	
		if (inventory_item == noone) {
			throw "Item not found in inventory"	
		}
	
		inventory_item_selected = inventory_item
		inventory_item_selected_index = inventory_item.index
	
		obj_hud.scale_inventory_item_selected()	
	}
}