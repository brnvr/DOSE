function area_add_actor_3d_ext(area, xpos, ypos, zpos, obj, xbase_offset, ybase_offset, var_struct = {}) {
	var xside, yside, inst;
	
	xside = choose(-1, 1);
	yside = choose(-1, 1);

	inst = area_add_actor_3d(	area,
								xpos+xside*xbase_offset,
								ypos+yside*ybase_offset,
								zpos, obj, {});
									
	if (variable_instance_exists(inst, "wall_offset")) {
		inst.x+=(xside == -1 ? inst.wall_offset : -inst.wall_offset);
		inst.y+=(yside == -1 ? inst.wall_offset : -inst.wall_offset);
	}
	
	return inst;
}