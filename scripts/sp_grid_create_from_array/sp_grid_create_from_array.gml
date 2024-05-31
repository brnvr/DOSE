function sp_grid_create_from_array(xstart, ystart, cell_width, cell_height, array, inverted=false) {
	var hcells, vcells, buffer;
	
	if (!is_array(array)) {
		throw $"{array} is not a valid array.";	
	}
	
	hcells = array_length(array[0]);
	vcells = array_length(array);
	
	if (hcells == 0 || vcells == 0) {
		throw "array must be bidimentional and not empty.";	
	}
	
	buffer = buffer_create(hcells*vcells, buffer_fixed, 1);
	
	for (var yy = 0; yy < vcells; yy++) {
		if (array_length(array[yy]) != hcells) {
			throw "every row of the array must have the same size.";
		}
		
		for (var xx = 0; xx < hcells; xx++) {
			buffer_write(buffer, buffer_bool, array[yy][xx]);
		}
	}
	
	return {
		id: SpGridCreateFromBuffer(hcells, buffer_base64_encode(buffer, 0, buffer_get_size(buffer))),
		hcells: hcells,
		vcells: vcells,
		buffer: buffer,
		xstart: xstart,
		ystart: ystart,
		cell_width: cell_width,
		cell_height: cell_height,
		paths: []
	}
}