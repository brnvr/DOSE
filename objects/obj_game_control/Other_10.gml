/// @description instance activation

if (!paused) {
	array_foreach(current_area.instances, function(instance) {
		instance_activate_object(instance)
	})
	
	instance_activate_object(obj_player.door_passing)
	
	with(obj_actor_3d_generic) {			
		if (id == obj_player.door_passing) continue
		if (id == obj_player.id) continue
		
		if (deactivate_by_area) {
			if (parent_area != other.current_area) {
				instance_deactivate_object(id)
			}
		}
		
		if (deactivate_with_distance) {
			var threshold = other.fog_end*2;

			if (x < obj_player.x-threshold ||
				x > obj_player.x+threshold ||
				y < obj_player.y-threshold ||
				y > obj_player.y+threshold) {
				
				instance_deactivate_object(id)
			}
		}
	}
	
	instance_activate_layer("Abstract")
	instance_activate_object(obj_player)
	instance_activate_object(obj_camera_3d_generic)
}