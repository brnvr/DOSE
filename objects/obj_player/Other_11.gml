/// @description looking

camera.yaw -= (global.cursor_x-(game_view_x + game_view_width*.5))*.35*obj_settings.mouse_sensitivity;
camera.pitch -= (global.cursor_y-(game_view_y + game_view_height*.5))*.35*obj_settings.mouse_sensitivity;

cursor_center();