if (keyboard_check_pressed(vk_escape)) {
	if (paused) {
		game_unpause();
	} else {
		if (obj_player.can_move) {
			game_pause();
		}
	}
}

if (!paused) {
	array_foreach(current_area.instances, function(instance) {
		instance_activate_object(instance);
	});
	
	instance_activate_object(obj_player.door_passing);
	
	with(obj_actor_3d_generic) {			
		if (id == obj_player.door_passing) continue; //
		if (id == obj_player.id) continue;
		
		if (deactivate_by_area) {
			if (parent_area != other.current_area) {
				instance_deactivate_object(id);
			}
		}
		
		if (deactivate_with_distance) {
			var threshold;

			threshold = other.fog_end*2;

			if (x < obj_player.x-threshold ||
				x > obj_player.x+threshold ||
				y < obj_player.y-threshold ||
				y > obj_player.y+threshold) {
				
				instance_deactivate_object(id);
			}
		}
	}
	
	instance_activate_layer("Abstract");
	instance_activate_object(obj_player);
	instance_activate_object(obj_camera_3d_generic);
}

if (camera_3d != noone) {
	audio_listener_position(camera_3d.x, camera_3d.y, camera_3d.z);

	audio_listener_orientation(
		camera_3d.xfrom-camera_3d.xto,
		camera_3d.yfrom-camera_3d.yto,
		camera_3d.zfrom-camera_3d.zto,
		camera_3d.xup,
		camera_3d.yup,
		camera_3d.zup
	);
}