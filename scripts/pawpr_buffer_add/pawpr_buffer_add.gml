function pawpr_buffer_add(buffer, value) {
	var buffer_length;
	
	buffer_length = array_length(buffer);
	
	for (var i = 0; i < buffer_length; i++) {
		if (is_undefined(buffer[i])) {
			buffer[i] = value;
			return;
		}
	}
	
	throw "Buffer is full.";
}
