function check_cheat(code) {
	var code_length = string_length(code)
	var ks_length = string_length(keyboard_string)
	
	if (ks_length >= code_length) {
		var found_cheat = string_upper(string_copy(keyboard_string, ks_length-code_length+1, code_length)) == string_upper(code)
		
		if (found_cheat) {
			obj_hud.show_notification($"Cheat activated: {string_lower(code)}")	
		}
		
		return found_cheat
	}
	
	return false
}