function area_add_instance_ext(area, xpos, ypos, obj, xbase_offset, ybase_offset, var_struct = {}) {
	var xside, yside, inst;
	
	xside = choose(-1, 1);
	yside = choose(-1, 1);

	inst = area_add_instance(	area,
								xpos+xside*xbase_offset,
								ypos+yside*ybase_offset,
								obj, {});
									
	if (variable_instance_exists(inst, "wall_offset")) {
		inst.x+=(xside == -1 ? inst.wall_offset : -inst.wall_offset);
		inst.y+=(yside == -1 ? inst.wall_offset : -inst.wall_offset);
	}
	
	return inst;
}