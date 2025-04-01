function variable_static_init(layer_id_or_name, ev_user) {
	if (instance_exists(obj_static)) {
		throw "Static object already exists."	
	}
	
	var objects = asset_get_ids(asset_object)
	
	instance_create_layer(0, 0, layer_id_or_name, obj_static, { ev_user, layer_id_or_name })

	array_foreach(objects, function(object) {
		if (object_is_ancestor(object, obj_actor_3d_generic)) {
			var container = instance_create_layer(0, 0, obj_static.layer_id_or_name, obj_static_variables_container)
		
			with (container) {
				event_perform_object(object, ev_other, obj_static.ev_user)	
			
				var names = variable_instance_get_names(id)
			
				array_foreach(names, method({ id, object }, function(name) {
					variable_static_set(object, name, variable_instance_get(id, name))
				}))
			
				instance_destroy()
			}
		}
	})
}