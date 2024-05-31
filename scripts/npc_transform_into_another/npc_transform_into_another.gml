function npc_transform_into_another(npc, obj_name, create_in_current_area=true) {
	if (!npc.is_transforming) {
		return instance_create_layer(0, 0, "Abstract", obj_npc_transformation, {
			npc: npc,
			obj_npc_other: asset_get_index(obj_name),
			create_in_current_area: create_in_current_area
		});
	}
	
	return noone;
}