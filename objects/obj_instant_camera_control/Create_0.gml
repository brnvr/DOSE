MAX_SHUTTER_YOFFSET = 270

camera_fov_y_original = obj_player.camera.fov_y
is_shooting = false
shutter_dir = 0
shutter_yoffset = MAX_SHUTTER_YOFFSET
camera = obj_player.inventory_find_item(obj_instant_camera)
photographs = obj_player.inventory_find_item(obj_instant_photographs)
subject = noone

ts_open_shutter = time_source_create(time_source_global, 11, time_source_units_frames, function() {
	shutter_dir = 1	
})

ts_stow_camera = time_source_create(time_source_global, 21, time_source_units_frames, function() {
	instance_destroy()
	obj_hud.add_message("You're out of film.")
})

obj_cursor.visible = false
obj_player.camera.fov_y = 30
	
camera_3d_update_projection(obj_player.camera)