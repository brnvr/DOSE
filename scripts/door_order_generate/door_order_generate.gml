function door_order_generate(length, max_door_number=999) {
	var arr []
	
	repeat(length) {
		array_push(arr, irandom(max_door_number));
	}
	
	return arr
}