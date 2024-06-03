camera_control = noone

on_select = function() {
	camera_control = instance_create_layer(0, 0, "Abstract", obj_instant_camera_control)
}

on_unselect = function() {
	instance_destroy(camera_control)
}

event_inherited();

