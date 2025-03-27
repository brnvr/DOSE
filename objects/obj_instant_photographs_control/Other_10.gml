/// @description load photographs

if (directory_exists("photographs")) {
	var filename = file_find_first("photographs/*.png", fa_none)
	
	photo_count = 0
	
	if (filename == "") {
		return
	}
	
	while (true) {
		filename = file_find_next()
		
		if (filename == "") {
			break	
		}
		
		var spr = sprite_add($"photographs/{filename}", 0, false, false, instant_photograph_width*.5, instant_photograph_height*.5)
		
		array_push(photographs, spr)
	}
	
	photo_count++
} else {
	photo_count = 0
}