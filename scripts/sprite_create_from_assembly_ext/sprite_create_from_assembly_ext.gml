function sprite_create_from_assembly(sprite, rows, xorigin=0, yorigin=0) {
	return sprite_create_from_assembly_ext(sprite, rows, 1, 1, c_white, 1, xorigin, yorigin);
}