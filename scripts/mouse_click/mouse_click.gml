function mouse_click(button_index, callback, arg=[], action=mb_actions.press) {
	var mouse_check, lock_button;
	
	lock_button = false;
	
	switch(action) {
		case mb_actions.press:
			mouse_check = mouse_check_button_pressed(button_index);
			lock_button = true;
			break;
			
		case mb_actions.hold:
			mouse_check = mouse_check_button(button_index);
			break;
			
		case mb_actions.release:
			mouse_check = mouse_check_button_released(button_index);
			lock_button = true;
			break;
	}
	
	if (mouse_check && !buffer_peek(obj_mouse_control.mouse_click_locked, button_index, buffer_bool)) {
		callback(arg);
		
		if (lock_button) {
			buffer_poke(obj_mouse_control.mouse_click_locked, button_index, buffer_bool, true);
			
			if (button_index == mb_any) {
				buffer_poke(obj_mouse_control.mouse_click_locked, mb_left, buffer_bool, true);
				buffer_poke(obj_mouse_control.mouse_click_locked, mb_middle, buffer_bool, true);
				buffer_poke(obj_mouse_control.mouse_click_locked, mb_right, buffer_bool, true);
			}
		}
	}
}