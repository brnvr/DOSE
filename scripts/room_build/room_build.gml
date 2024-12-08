function room_build(room, seed_group, block_size, door_passage_side_width) {
	var wall = array_choose(seed_group[sg.walls]);
	var door = array_choose(seed_group[sg.doors]);
	var lamp = array_choose(seed_group[sg.lamps]);
	
	room.started_building = true;

	for (var i = 0; i < room.hlength; i++) {
		var xpos = room.x + i*block_size;
		
		area_add_actor_3d(room, xpos, room.y, room.z, obj_wall_random_generic, {
			zrotation: 90,
			sprite_index: wall,
			passage: room.walls.north[i] >= 1
		});
		
		area_add_actor_3d(room, xpos+block_size, room.y+room.vlength*block_size, room.z, obj_wall_random_generic, {
			zrotation: 270,
			sprite_index: wall,
			passage: room.walls.south[i] >= 1
		});
		
		if (room.walls.north[i] == 2) {
			array_push(room.doors, area_add_actor_3d(room, xpos+door_passage_side_width, room.y, room.z, door, {
				zrotation: 90,
				opening_direction: angular.clockwise,
				locked: take_chance(room.prob_door_locked),
				areas: {
					south: room
				}
			}));
		}

		if (room.walls.south[i] == 2) {
			array_push(room.doors, area_add_actor_3d(room, xpos+door_passage_side_width, room.y+room.vlength*block_size, room.z, door, {
				zrotation: 90,
				opening_direction: angular.counterclockwise,
				locked: take_chance(room.prob_door_locked),
				areas: {
					north: room
				}
			}));
		}
	}
	
	for (var i = 0; i < room.vlength; i++) {
		var ypos = room.y + i*block_size;
		
		area_add_actor_3d(room, room.x+room.hlength*block_size, ypos, room.z, obj_wall_random_generic, {
			zrotation: 0,
			sprite_index: wall,
			passage: room.walls.east[i] >= 1
		});
		
		area_add_actor_3d(room, room.x, ypos+block_size, room.z, obj_wall_random_generic, {
			zrotation: 180,
			sprite_index: wall,
			passage: room.walls.west[i] >= 1
		});
		
		if (room.walls.east[i] == 2) {
			array_push(room.doors, area_add_actor_3d(room, room.x+room.hlength*block_size, ypos+door_passage_side_width, room.z, door, {
				zrotation: 0,
				opening_direction: angular.clockwise,
				locked: take_chance(room.prob_door_locked),
				areas: {
					west: room
				}
			}));
		}
		
		if (room.walls.west[i] == 2) {
			array_push(room.doors, area_add_actor_3d(room, room.x, ypos+door_passage_side_width, room.z, door, {
				zrotation: 0,
				opening_direction: angular.counterclockwise,
				locked: take_chance(room.prob_door_locked),
				areas: {
					east: room,
				}
			}));
		}
	}
	
	area_add_actor_3d(room, room.x+room.hlength*block_size*.5, room.y+room.vlength*block_size*.5, room.z, obj_lamp_generic, {
		billboard: true,
		sprite_index: lamp
	});
}