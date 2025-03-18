with (obj_control) {
	event_user(15)	
}

obj_control.current_area = global.custom_areas[ca.entrance_hall]

global.camera_2d = instance_create_layer(0, -25, "Abstract", obj_camera_2d_generic)
global.camera_3d = obj_player.camera

instance_create_layer(0, 0, "Abstract", obj_fog_overlay)
instance_create_layer(0, 0, "Abstract", obj_vignette)
instance_create_layer(0, 0, "Abstract", obj_cursor)
instance_create_layer(0, 0, "Abstract", obj_main_menu)

view_set_visible(views.view_2d, true)
view_set_visible(views.view_3d, true)
view_set_camera_object(views.view_2d, global.camera_2d)
view_set_camera_object(views.view_3d, global.camera_3d)

obj_control.goto_thisside()

with (obj_control) {
	event_user(0)	
}