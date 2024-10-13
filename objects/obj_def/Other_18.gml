/// @description Sets photo count

if (directory_exists("photographs")) {
	var filename = file_find_first("photographs/*.png", fa_none)
	
	if (filename == "") {
		global.photo_count = 0
		
		return
	}
	
	var max_number = real(string_replace(filename, ".png", ""))
	
	while (true) {
		filename = file_find_next()
		
		if (filename == "") {
			break	
		}
		
		var number = real(string_replace(filename, ".png", ""))
		
		max_number = max(number, max_number)
	}
	
	global.photo_count = max_number+1
} else {
	global.photo_count = 0
}