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
			var threshold = other.fog_end*2;

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

if (global.camera_3d != noone) {
	audio_listener_position(global.camera_3d.x, global.camera_3d.y, global.camera_3d.z);

	audio_listener_orientation(
		global.camera_3d.xfrom-global.camera_3d.xto,
		global.camera_3d.yfrom-global.camera_3d.yto,
		global.camera_3d.zfrom-global.camera_3d.zto,
		global.camera_3d.xup,
		global.camera_3d.yup,
		global.camera_3d.zup
	);
}