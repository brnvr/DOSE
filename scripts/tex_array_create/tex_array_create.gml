function tex_array_create(list) {
	var arr, length;
	
	length = array_length(list);
	
	for (var i = 0; i < length; i++) {
		var item = list[i];
		
		repeat(item[1]) {
			array_push(arr, item[0]);	
		}
	}
	
	return arr;
}