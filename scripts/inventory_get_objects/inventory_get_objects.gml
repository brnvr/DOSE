function inventory_get_objects(repeat_for_number) {
	with (obj_player) {
		var result = []
	
		array_foreach(inventory, method({ result, repeat_for_number }, function(item) {
			if (repeat_for_number) {
				repeat(item.number) {
					array_push(result, item.object)		
				}
			} else {
				array_push(result, item.object)	
			}
		}))
	
		return result;	
	}
}