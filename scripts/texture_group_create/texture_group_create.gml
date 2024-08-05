function texture_group_create(base) {
	var texture_group, keys, n_keys;
	
	texture_group = {};
	keys = struct_get_names(base);
	n_keys = array_length(keys);
	
	for (var i = 0; i < n_keys; i++) {
		var arr = variable_struct_get(base, keys[i]);
		var n_items = array_length(arr);
		
		var texture_subgroup = [];
		
		variable_struct_set(texture_group, keys[i], []);
		
		for (var j = 0; j < n_items; j++) {
			var item = arr[j];
			
			repeat (item.chance) {
				array_push(texture_subgroup, item.texture);	
			}
		}
	}
	
	return texture_group;
}