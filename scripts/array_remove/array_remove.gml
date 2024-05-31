function array_remove(arr, value) {
	var index;
	
	index = array_find(arr, value);
	if (index == -1) return false;
	array_delete(arr, index, 1);
	
	return true;
}