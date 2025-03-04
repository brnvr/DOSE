function area_destroy_instance(area, instance) {
	instance_activate_object(instance);
		
	if (!instance_exists(instance)) return;	
	
	if (object_is_ancestor(instance.object_index, obj_door_generic)) {
		if (area_detach_door(area, instance)) return;
	}
	
	instance_destroy(instance);
	
	if (obj_player.actor_hover == instance) {
		obj_player.actor_hover = noone;	
	}
}