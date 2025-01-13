function create_deep_copy(src, filter = undefined) {
	var str = json_stringify(src, false, filter)
	
	return json_parse(str)
}