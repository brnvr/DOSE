function string_pad_left(str, char, length) {
	while(string_length(str) < length) {
		str = char + str;	
	}
	
	return str;
}