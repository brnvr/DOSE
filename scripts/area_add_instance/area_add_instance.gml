function area_add_instance(area, xpos, ypos, obj, var_struct = {}) {
	var inst;
	
	inst = instance_create_layer(xpos, ypos, "Default", obj, var_struct);
	
	area_append_instance(area, inst);
	return inst;
}