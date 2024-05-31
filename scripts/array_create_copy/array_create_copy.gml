function array_create_copy(array_src, index=0, length=-1) {
	var arr;
	
	arr = [];
	
	array_copy(arr, 0, array_src, index, length == -1 ? array_length(array_src) : length);
	
	return arr;
}