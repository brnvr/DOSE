ds_grid_destroy(collision_grid);

if (!is_undefined(sp_grid)) {
	sp_grid_delete(sp_grid);
}

event_inherited();