function array_choose(array, remove_item=false) {
	var index, length, value;
	
	length = array_length(array);
	
	if (length == 0) throw "Array must have at least one element";
	
	index = length == 1 ? 0 : irandom(length-1);
	value = array[index];
	
	if (remove_item) {
		array_delete(array, index, 1);
	}
	
	return value;
}