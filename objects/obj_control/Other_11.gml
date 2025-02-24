/// @description move player to start

obj_control.current_area = global.custom_areas[ca.entrance_hall]
event_user(0)

with obj_player {
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
			eye_height = EYE_HEIGHT_SITTING
			sit(obj_couch.id)	
		}
	)()
}
