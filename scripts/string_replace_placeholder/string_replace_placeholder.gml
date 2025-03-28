function string_replace_placeholder(str, placeholder, new_substring) {
	var is_begining_of_sentence = true
	var placeholder_position = string_pos(placeholder, str)
		
	for (var i = placeholder_position-2; i > 0; i--) {
		var char = string_char_at(str, i)

		if (char == " ") continue
		if (char == ".") {
			is_begining_of_sentence = true
			break
		}
			
		is_begining_of_sentence = false
		break
	}
		
	if (is_begining_of_sentence) {
		new_substring = string_capitalize_first_letter(new_substring)
	}
		
	return string_replace(str, "{" + placeholder + "}", new_substring)
}