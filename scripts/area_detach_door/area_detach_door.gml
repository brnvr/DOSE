function area_detach_door(area, door) {
	switch (door.orientation) {
		case alignment.vertical:
			if (door.areas[cardinal.west] == area) {
				door.areas[cardinal.west] = noone;
				
				return door.areas[cardinal.east] != noone;
			}
			
			if (door.areas[cardinal.east] == area) {
				door.areas[cardinal.east] = noone;	
				
				return door.areas[cardinal.west] != noone;
			}
			
			break;
		
		case alignment.horizontal:
			if (door.areas[cardinal.north] == area) {
				door.areas[cardinal.north] = noone;
				
				return door.areas[cardinal.south] != noone;
			}
			
			if (door.areas[cardinal.south] == area) {
				door.areas[cardinal.south] = noone;
				
				return door.areas[cardinal.north] != noone;
			}
			
			break;
	}
}