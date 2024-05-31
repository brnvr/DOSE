function string_from_file(path) {
	var str, file;
	
	file = file_text_open_read(path);
	str = "";
	
	while (!file_text_eof(file)) {
		str += file_text_readln(file);
	}
	
	file_text_close(file);
	return str;
}