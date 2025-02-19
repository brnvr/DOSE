grid_size = grid_size ?? 1

collision_grid = ds_grid_create(grid_size, grid_size);
sp_grid = undefined;

begin_pathfinding = function() {
	if (is_undefined(sp_grid)) {
		sp_grid = sp_grid_create_from_ds_grid(x, y, default_block_size, default_block_size, collision_grid, true); 
	}
}

event_inherited();

