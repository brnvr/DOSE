function area_add_actor_3d(area, xpos, ypos, zpos, obj, var_struct = {}) {
	var inst;
	
	inst = instance_create_layer(xpos, ypos, "Default", obj, var_struct);
	inst.z += zpos;
	
	area_append_instance(area, inst);
	return inst;
}