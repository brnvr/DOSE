function sp_grid_create_from_ds_grid(xstart, ystart, cell_width, cell_height, ds_grid, inverted=false) {
	var hcells, vcells, buffer;
	
	hcells = ds_grid_width(ds_grid);
	vcells = ds_grid_height(ds_grid);
	
	buffer = buffer_create(hcells*vcells, buffer_fixed, 1);
	
	for (var yy = 0; yy < vcells; yy++) {
		for (var xx = 0; xx < hcells; xx++) {
			buffer_write(buffer, buffer_bool, inverted ? !ds_grid[# xx, yy] : ds_grid[# xx, yy]);
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