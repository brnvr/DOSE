function actor_3d_create(xpos, ypos, zpos, obj, var_struct = {}, layer_id_or_name="Default") {
	if (!variable_struct_exists(var_struct, "z")) {
		var_struct.z = zpos;
	}
	
	return instance_create_layer(xpos, ypos, layer_id_or_name, obj, var_struct);
}