function array_foreach(arr, funct, arg = []) {
	var length;
	
	length = array_length(arr);
	
	for (var i = 0; i < length; i++) {
		funct(arr[i], i, arg);
	}
}