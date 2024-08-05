function array_create_weighted(items_and_weights) {
	var arr = []
	var n_items = array_length(items_and_weights);
	
	for (var i = 0; i < n_items; i++) {
		var item_and_weight = items_and_weights[i]

		repeat(item_and_weight[1]) {
			if (is_array(item_and_weight[0])) {
				
				var length = array_length(item_and_weight[0])
				
				for (var j = 0; j < length; j++) {
					array_push(arr, item_and_weight[0][j]);
				}
				
				continue
			}
			
			array_push(arr, item_and_weight[0])
		}
	}
	
	return arr;
}