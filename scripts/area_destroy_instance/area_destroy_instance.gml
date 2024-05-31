function area_destroy_instance(area, instance) {
	instance_activate_object(instance);
		
	if (!instance_exists(instance)) return;	
	
	/*if (object_is_ancestor(instance.object_index, obj_pathway_generic)) {
		var other_end;
		
		other_end = instance.other_end;
		
		if (other_end != noone) {
			if (other_end.areas[0] == area) {
				other_end.areas = [other_end.areas[1]];	
			} else if (other_end.areas[1] == area) {
				other_end.areas = [other_end.areas[0]];	
			} else {
				throw "erro em area_destroy_instance: other_end.areas não contém área sendo destruída";	
			}
		}
	}*/
	
	if (object_is_ancestor(instance.object_index, obj_door_generic)) {
		if (area_detach_door(area, instance)) return;
	}
	
	instance_destroy(instance);
	
	if (obj_player.actor_hover == instance) {
		obj_player.actor_hover = noone;	
	}
}