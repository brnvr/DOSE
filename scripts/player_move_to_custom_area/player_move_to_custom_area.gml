function player_move_to_custom_area(door_origin, area) {
	var door_dest = area.main_door
	
	if (door_origin.orientation == alignment.vertical) {
		if (obj_player.x > door_origin.x) {
			area.other_end_direction = cardinal.west
		} else {
			area.other_end_direction = cardinal.east
		}
	}
	else {
		if (obj_player.y > door_origin.y) {
			area.other_end_direction = cardinal.north
		} else {
			area.other_end_direction = cardinal.south
		}	
	}
	
	player_move_to_door(door_origin, door_dest)
	
	door_dest.vbuff_list = door_origin.vbuff_list
	door_dest.texture_list = door_origin.texture_list
	door_dest.door_number = door_origin.door_number
	
	/*if (door_dest.opening_direction == door_origin.opening_direction) {
		door_mirror(door_dest)
	} else {
		door_dest.opening_direction = !door_dest.opening_direction	
	}*/
	
	if (area.other_end_direction == cardinal.east || area.other_end_direction == cardinal.north) {
		door_mirror(door_dest)
		door_dest.opening_direction = door_origin.opening_direction
	} else {
		door_dest.opening_direction = door_origin.opening_direction	
	}
	
	if (door_dest.orientation == alignment.vertical) {
		if (obj_player.x > door_dest.x) {
			door_dest.number_side = cardinal.west	
		} else {
			door_dest.number_side = cardinal.east	
		}
	}
	else {
		if (obj_player.y > door_dest.y) {
			door_dest.number_side = cardinal.north
		} else {
			door_dest.number_side = cardinal.south
		}	
	}
	
	instance_activate_object(door_dest)
	
	with (door_dest) {
		actor_3d_update_transformation_matrix()	
	}
}

function player_move_to_door(door_origin, door_dest, invert_dir=false) {
	var dest_rotation = door_dest.zrotation + (invert_dir ? 180 : 0)
	
	var door_origin_matrix = matrix_build(door_origin.x, door_origin.y, door_origin.z, 
	door_origin.xrotation, door_origin.yrotation, door_origin.zrotation, door_origin.xscale, door_origin.yscale, door_origin.zscale)
	
	var door_dest_matrix = matrix_build(door_dest.x, door_dest.y, door_dest.z, 
	door_dest.xrotation, door_dest.yrotation, door_dest.zrotation, door_dest.xscale, door_dest.yscale, door_dest.zscale)
	
	var door_dest_center = bbox_get_center(door_dest.bbox_list[0], door_dest_matrix)
	var door_origin_center = bbox_get_center(door_origin.bbox_list[0], door_origin_matrix)
	
	var rel_pos = relative_positioning(obj_player.x, obj_player.y, door_origin_center[0], door_origin_center[1], door_origin.zrotation+90)
	var angle_dif = angle_difference(door_origin.zrotation, dest_rotation) + (rel_pos ? 180 : 0)
	
	var rotation_matrix = matrix_build(0, 0, 0, 0, 0, angle_dif, 1, 1, 1)
	var vector_rotated = matrix_transform_vertex(rotation_matrix, obj_player.x-door_origin_center[0], obj_player.y-door_origin_center[1], 0)
	
	obj_player.x = door_dest_center[0]+vector_rotated[0]
	obj_player.y = door_dest_center[1]+vector_rotated[1]
	
	obj_player.update_camera_position()

	obj_player.camera.yaw += angle_dif
}