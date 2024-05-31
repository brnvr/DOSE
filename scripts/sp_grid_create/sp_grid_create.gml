function sp_grid_create(xstart, ystart, hcells, vcells, cell_width, cell_height) {
	return {
		id: SpGridCreate(hcells, vcells),
		xstart: xstart,
		ystart: ystart,
		hcells: hcells,
		vcells: vcells,
		cell_width: cell_width,
		cell_height: cell_height,
		buffer: buffer_create(hcells*vcells, buffer_fixed, 1),
		paths: []
	}
}