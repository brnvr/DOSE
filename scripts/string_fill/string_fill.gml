function string_fill(str_final, str_current="") {
	if (string_length(str_final) > string_length(str_current)) {
		return str_current + string_char_at(str_final, string_length(str_current)+1);
	}
	
	return str_current;
}