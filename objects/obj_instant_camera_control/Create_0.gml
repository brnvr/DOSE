MAX_SHUTTER_YOFFSET = 270

camera_fov_y_original = obj_player.camera.fov_y
is_shooting = false
shutter_dir = 0
shutter_yoffset = MAX_SHUTTER_YOFFSET
photographs = obj_player.inventory_find_item(object_get_index(obj_instant_photographs))

ts_open_shutter = time_source_create(time_source_global, 10, time_source_units_frames, function() {
	shutter_dir = 1	
})

obj_cursor.visible = false
obj_player.camera.fov_y = 30
	
camera_3d_update_projection(obj_player.camera)