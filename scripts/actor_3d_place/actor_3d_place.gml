function actor_3d_place(xx, yy, zz, obj, collidable_only=true) {
	var bbox0, bbox1;
	
	for (var i = 0; i < array_length(bbox_transformed_list); i++) {
		bbox0 = bbox_transformed_list[i];
	
		with (obj) {
			if (id == other.id) continue;
			
			if (collidable || !collidable_only) {
				for (var k = 0; k < array_length(bbox_transformed_list); k++) {
					bbox1 = bbox_transformed_list[k];
	
					if (xx+bbox0[3] > x+bbox1[0] && xx+bbox0[0] < x+bbox1[3] &&
						yy+bbox0[4] > y+bbox1[1] && yy+bbox0[1] < y+bbox1[4] &&
						zz+bbox0[5] > z+bbox1[2] && zz+bbox0[2] < z+bbox1[5]) {
				
						return id;
					}
				}
			}
		}
	}
	
	
	
	return noone;
}