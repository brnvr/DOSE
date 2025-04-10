function corridor_populate(corridor, seed_group, block_size, realm, area_events = global.area_events, corridor_events = global.corridor_events) {
	static create_actors = function(corridor, block_size, number, cells_used, arr, allow_repeated=true) {
		if (!allow_repeated) {
			arr = array_create_copy(arr)	
		}
		
		for (var i = 0; i < number; i++) {
			var cell_selected_coord = undefined
			var cell_selected = undefined
		
			if (array_length(arr) == 0) {
				break
			}
			
			var no_empty_space = false
		
			do {
				if (array_length(cells_used) == 0) {
					no_empty_space = true
					break
				}
			
				cell_selected_coord = array_choose(cells_used, true)
				cell_selected = corridor.grid[# cell_selected_coord[0], cell_selected_coord[1]]
			}
			until (cell_selected[corridor_cell_prop.type] == 0 && !cell_selected[corridor_cell_prop.occupied] && cell_selected[corridor_cell_prop.orientation] != -1)
		
			if (no_empty_space) {
				break
			}
		
			var actor_selected = array_choose(arr, !allow_repeated)
			
			if (!allow_repeated) {
				if (instance_exists(actor_selected)) {
					break	
				}	
			}

			if (cell_selected[corridor_cell_prop.orientation] == alignment.vertical) {
				area_add_actor_3d_ext(	corridor,
					corridor.x+block_size*(cell_selected_coord[0]+.5),
					corridor.y+block_size*(cell_selected_coord[1]+.5),
					corridor.z, actor_selected, block_size*.25, 0)
			} else {
				area_add_actor_3d_ext(	corridor,
					corridor.x+block_size*(cell_selected_coord[0]+.5),
					corridor.y+block_size*(cell_selected_coord[1]+.5),
					corridor.z, actor_selected, 0, block_size*.25)
			}
							
			corridor.grid[# cell_selected_coord[0], cell_selected_coord[1]][corridor_cell_prop.occupied] = true
		}
	}
	
	var populate_area = true
	var corridor_events_in_realm = events_in_realm(corridor_events, realm)
	var area_events_in_realm = events_in_realm(area_events, realm)
	var arr_ev = events_get_functions(array_concat(area_events_in_realm, corridor_events_in_realm))
	
	while (random_event(corridor.prob_event) && array_length(arr_ev) > 0) {
		var ev = array_choose(arr_ev, true)
		
		if (ev(corridor, block_size, create_actors)) {
			populate_area = false
		}
	}
	
	if (!populate_area) {
		return	
	}
	
	var n_characters = 0
	var n_items = 0

	repeat(corridor.n_segments) {
		while (random_event(corridor.prob_character)) n_characters++
		while (random_event(corridor.prob_item)) n_items++
	}
	
	var _cells_used
	
	if (n_characters > 0 || n_items > 0) {
		_cells_used = array_create_copy(corridor.cells_used)
	} else {
		_cells_used = corridor.cells_used
	}
	
	create_actors(corridor, block_size, n_characters, _cells_used, seed_group[sg.characters], false)
}