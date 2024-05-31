function string_split(str, char) {
	var length, char_at, arr, arr_index;
	
	length = string_length(str);
	arr_index = 0;
	arr = [""];
	
	for (var i = 1; i <= length; i++) {
		char_at = string_char_at(str, i);
		
		if (char_at == char) {
			arr[++arr_index] = "";
		} else {
			arr[arr_index] += char_at;
		}
	}
	
	return arr;
}