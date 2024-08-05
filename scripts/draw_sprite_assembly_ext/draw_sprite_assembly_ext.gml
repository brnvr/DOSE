function draw_sprite_assembly_ext(sprite, x, y, rows, xscale, yscale, col, alpha) {
	var part_width, part_height, nparts, column;
	
	part_width = sprite_get_width(sprite)*xscale;
	part_height = sprite_get_height(sprite)*yscale;
	nparts = sprite_get_number(sprite);
	column = 0;

	for (var i = 0; i < nparts; i++) {
		var row = i mod rows;
		draw_sprite_ext(sprite, i, x+part_width*row, y+part_height*column, xscale, yscale, 0, col, alpha);
		if (row == rows-1) column++;
	}
}