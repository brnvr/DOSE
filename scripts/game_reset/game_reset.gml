function game_reset(prob_drop_item = 0) {
	with (obj_game_control) {
		goto_thisside()
		current_area = global.custom_areas[ca.entrance_hall]
		current_area.neighbors = []
		event_user(0)	
		
		array_foreach(current_area.instances, function(instance) {
			try {
				instance_activate_object(instance)
			
				instance.parent_area = current_area	
			}
			catch(e) {
				show_debug_message($"Instance {instance} not found when resetting game.")
			}
		})
	}

	with obj_player {
		reset()
		
		choose(
			function() {
				x = obj_door_entrance.x + 64
				y = obj_door_entrance.y - 48
	
				camera.yaw = 180
				camera.pitch = 0	
			},
		
			function() {
				x = 512
				y = 608
	
				camera.yaw = 270
				camera.pitch = 12	
			},
		
			function() {
				eyes_height = EYES_HEIGHT_SITTING
				sit(obj_couch.id)	
			}
		)()
		
		if (prob_drop_item > 0) {
			var inventory_objects = inventory_get_objects(true)
			
			array_foreach(inventory_objects, method({ prob_drop_item }, function(item) {
				if (random_event(prob_drop_item)) {
					inventory_remove_item(item)
				}
			}))
		}
	}
}