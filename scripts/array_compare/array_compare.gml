function array_compare(array_0, array_1) {
	var length;

	length = array_length(array_0);
	
	if (length != array_length(array_1)) {
		return false;
	}

	for (var i = 0; i < length; i++) {
		if (array_0[i] != array_1[i]) {
			return false;
		}
	}
	
	return true;
}