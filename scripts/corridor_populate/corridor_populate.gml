function corridor_populate(corridor, seed_group, block_size) {
	var n_characters, n_items, _cells_used;

	static create_actors = function(corridor, block_size, number, cells_used, arr, allow_repeated=true) {
		if (!allow_repeated) {
			arr = array_create_copy(arr);		
		}
		
		for (var i = 0; i < number; i++) {
			var cell_selected_coord, cell_selected, actor_selected, no_empty_space;
		
			if (array_length(arr) == 0) {
				break;	
			}
			
			no_empty_space = false;
		
			do {
				if (array_length(cells_used) == 0) {
					no_empty_space = true;
					break;	
				}
			
				cell_selected_coord = array_choose(cells_used, true);
				cell_selected = corridor.grid[# cell_selected_coord[0], cell_selected_coord[1]];
			}
			until (cell_selected[corridor_cell_prop.type] == 0 && !cell_selected[corridor_cell_prop.occupied] && cell_selected[corridor_cell_prop.orientation] != -1);
		
			if (no_empty_space) break;
		
			actor_selected = array_choose(arr, !allow_repeated);

			if (cell_selected[corridor_cell_prop.orientation] == alignment.vertical) {
				area_add_actor_3d_ext(	corridor,
					corridor.x+block_size*(cell_selected_coord[0]+.5),
					corridor.y+block_size*(cell_selected_coord[1]+.5),
					corridor.z, actor_selected, block_size*.25, 0);
			} else {
				area_add_actor_3d_ext(	corridor,
					corridor.x+block_size*(cell_selected_coord[0]+.5),
					corridor.y+block_size*(cell_selected_coord[1]+.5),
					corridor.z, actor_selected, 0, block_size*.25);
			}
							
			corridor.grid[# cell_selected_coord[0], cell_selected_coord[1]][corridor_cell_prop.occupied] = true;
		}
	}
	
	var arr_ev = array_concat(area_events, corridor_events)
	
	while (take_chance(corridor.prob_event) && array_length(arr_ev) > 0) {
		var ev = array_choose(arr_ev, true)
		
		if (ev(corridor, block_size, create_actors)) {
			return
		}
	}
	
	n_characters = 0;
	n_items = 0;

	repeat(corridor.n_segments) {
		while (take_chance(corridor.prob_character)) n_characters++;
		while (take_chance(corridor.prob_item)) n_items++;
	}
	
	if (n_characters > 0 || n_items > 0) {
		_cells_used = array_create_copy(corridor.cells_used);
	} else {
		_cells_used = corridor.cells_used;	
	}
	
	create_actors(corridor, block_size, n_characters, _cells_used, seed_group[sg.characters], false);
}