function json_from_file(path) {
	var str;
	
	str = string_from_file(path);
	
	return json_parse(str);
}