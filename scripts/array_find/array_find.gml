function array_find(arr, val) {
	var arr_length;
	
	arr_length = array_length(arr);
	
	for (var i = 0; i < arr_length; i++) {
		if (arr[i] == val) return i;	
	}
	
	return -1;
}