function corridor_cell_has_doors(cell) {
	return	cell[corridor_cell_prop.door_east] >= 0 ||
			cell[corridor_cell_prop.door_west] >= 0 ||
			cell[corridor_cell_prop.door_north] >= 0 ||
			cell[corridor_cell_prop.door_south] >= 0;
}