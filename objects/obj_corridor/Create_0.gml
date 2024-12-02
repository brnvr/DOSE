grid = ds_grid_create(grid_size, grid_size);
n_segments = 0;
building_queue = [];

reset = corridor_on_reset;

add_to_building_queue = function(seed_group, block_size, door_passage_side_width) {
	array_push(building_queue, [seed_group, block_size, door_passage_side_width]);
}

get_is_building = function() {
	return started_building && array_length(building_queue) > 0;	
}

event_inherited();