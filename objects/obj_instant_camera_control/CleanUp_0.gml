time_source_destroy(ts_open_shutter)
time_source_destroy(ts_stow_camera)

obj_cursor.visible = true
obj_player.camera.fov_y = camera_fov_y_original

camera_3d_update_projection(obj_player.camera)
cursor_set_sprite(interactable_get_hover_sprite(obj_player.actor_hover))