function door_mirror(door) {
	door.zrotation += 180
	door.x -= dsin(door.zrotation)*(wall_passage_width+16)
	door.y -= dcos(door.zrotation)*(wall_passage_width+16)
	door.zrotation_start += 180
	var area_west = door.areas[cardinal.west]
	var area_east = door.areas[cardinal.east]
	var area_north = door.areas[cardinal.north]
	var area_south = door.areas[cardinal.south]
	door.areas[cardinal.west] = area_east
	door.areas[cardinal.east] = area_west
	door.areas[cardinal.north] = area_south
	door.areas[cardinal.south] = area_north
	door.mirrored = !door.mirrored
	
	instance_activate_object(door)
	
	with(door) {
		actor_3d_update_bbox()
	}
}