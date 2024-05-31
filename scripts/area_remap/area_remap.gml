function area_remap(area, seed_group) {
	array_foreach(area.instances, method({ seed_group: seed_group }, function(instance) {
		if (!instance_exists(instance)) {
			return;	
		}
		
		var remap_function = variable_instance_get(instance, "remap");
		
		if (!is_undefined(remap_function)) {
			if (instance.seed_group_index < 0) {
				throw $"seed_group_index undefined for instance {instance}.";	
			}
			
			var new_value = array_choose(seed_group[instance.seed_group_index]);
			
			remap_function(new_value);
		}
	}))
}