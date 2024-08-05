function string_break_lines(str, max_width, font=draw_get_font(), scale=1) {
	var str_new, font_previous;
	
	str_new = "";
	font_previous = draw_get_font();
	draw_set_font(font);

	for (var i = 1; i <= string_length(str); i++) {
		var char = string_char_at(str, i);
		str_new += char;
		
		if (string_width(str_new)*scale > max_width) {
			for (var j = string_length(str_new); j >= 1; j--) {
				var str_new_char = string_char_at(str_new, j);
				
				if (str_new_char == "\\") {
					if (string_char_at(str_new, j+1) == "n") {
						break;	
					}
				}
				
				if (str_new_char == " ") {
					str_new = string_insert("\n", str_new, j);
					str_new = string_delete(str_new, j+1, 1);
					break;
				}
			}
		}
	}
	
	draw_set_font(font_previous);
	
	return str_new;
}