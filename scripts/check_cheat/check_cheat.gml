function check_cheat(code) {
	var code_length = string_length(code)
	var ks_length = string_length(keyboard_string)
	
	if (ks_length >= code_length) {
		return string_upper(string_copy(keyboard_string, ks_length-code_length+1, code_length)) == string_upper(code)
	}
	
	return false
}