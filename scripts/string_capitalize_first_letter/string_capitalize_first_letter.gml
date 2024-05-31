function string_capitalize_first_letter(str) {
	return string_upper(string_char_at(str, 1)) + string_copy(str, 2, string_length(str)) 
}