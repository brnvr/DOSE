function inventory_find_item(object) {
	with (obj_player) {
		object = object_get_index(object)
	
		var index = array_find_index(inventory, method({ object: object }, function(item) {
			return item.object == object	
		}))
	
		if (index >= 0) {
			return inventory[index]	
		}
	
		return noone	
	}
}