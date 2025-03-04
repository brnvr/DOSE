/// @description moving

var move_speed = WALK_SPEED * stamina
var xoffset = 0
var yoffset = 0

if (keyboard_check(obj_settings.key_sprint)) {
	move_speed = RUN_SPEED * stamina
}

if (envenoming > 0) {
	move_speed -= move_speed / 2 * envenoming	
}

move(function(offset, move_speed) {
	var xoffset = 0, yoffset = 0
	
	if (keyboard_check(obj_settings.key_move_forward)) {
		xoffset += move_speed*dcos(camera.yaw)
		yoffset -= move_speed*dsin(camera.yaw)
	}

	if (keyboard_check(obj_settings.key_move_backward)) {
		xoffset -= move_speed*dcos(camera.yaw)
		yoffset += move_speed*dsin(camera.yaw)
	}

	if (keyboard_check(obj_settings.key_move_left)) {
		xoffset -= move_speed*dsin(camera.yaw)
		yoffset -= move_speed*dcos(camera.yaw)
	}

	if (keyboard_check(obj_settings.key_move_right)) {
		xoffset += move_speed*dsin(camera.yaw)
		yoffset += move_speed*dcos(camera.yaw)
	}
	
	offset[0] = xoffset
	offset[1] = yoffset
}, move_speed)