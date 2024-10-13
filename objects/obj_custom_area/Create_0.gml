other_end_area = noone
other_end_door = noone

if (main_door != noone) {
	main_door.cullmode = cull_noculling	
}

event_inherited()

instances = array_map(layer_get_all_elements(layer_name), function(layer_instance_id) {
	return layer_instance_get_instance(layer_instance_id)
})

array_foreach(instances, function(instance) {
	layer_add_instance("Default", instance)
	instance.parent_area = id
	
	if (object_is_ancestor(instance.object_index, obj_door_generic)) {
		with (instance) {
			var cardinal_direction = get_cardinal_direction(zrotation)

			areas[cardinal_opposite(cardinal_direction)] = other.id	
		}
	}
});