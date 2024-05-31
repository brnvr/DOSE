function actor_3d_position(xx, yy, zz, obj, collidable_only=true) {
	var bbox;
	
	with (obj) {
		if (id == other.id) continue;
		
		if (!variable_instance_exists(id, "bbox_transformed_list")) {
			return;	
		}
	
		if (collidable || !collidable_only) {
			
			for (var j = 0; j < array_length(bbox_transformed_list); j++) {
				bbox = bbox_transformed_list[j];
	
				if (x+bbox[3] > xx && x+bbox[0] < xx &&
					y+bbox[4] > yy && y+bbox[1] < yy &&
					z+bbox[5] > zz && z+bbox[2] < zz) {
					
					return id;
				}
			}
		}
	}
	
	return noone;
}