function xorcrypt(str, key) {
	if (!is_string(str)) throw "\"str\" must be a string."
	if (!is_string(key)) throw "\"key\" must be a string."
	
	var key_length = string_length(key)
	
	if (key_length < 1) throw "\"key\" is empty.";
	
	var str_length = string_length(str);
	var result = "";
	
	for (var i = 1; i <= str_length; i+=1) {
	    var code;
    
	    code = ord(string_char_at(str, i)) ^ ord(string_char_at(key, 1 + i mod key_length));
	    result = string_insert(chr(code), result, i);
	}

	return result;
}