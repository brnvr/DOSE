function door_make_room(dir) {
	var pos, xst, yst, opposite_dir, dest_area;
		
	opposite_dir = cardinal_opposite(dir);
	dest_area = actor_3d_create(0, 0, 0, obj_room, {
		on_built: function(room) {
			room_populate(room, obj_control.seed_group, default_block_size);
		}
	});
	
	room_generate(dest_area);
	pos = room_add_passage_random(dest_area, opposite_dir);
				
	switch (dir) {
		case cardinal.east:
			xst = x;
			yst = y-wall_passage_width-pos*default_block_size;
			areas[cardinal.east] = dest_area;
			break;
				
		case cardinal.west:
			xst = x-dest_area.hlength*default_block_size;
			yst = y-wall_passage_width-pos*default_block_size;
			areas[cardinal.west] = dest_area;
			break;
				
		case cardinal.south:
			xst = x-wall_passage_width-pos*default_block_size;
			yst = y;
			areas[cardinal.south] = dest_area;
			break;
				
		case cardinal.north:
			xst = x-wall_passage_width-pos*default_block_size;
			yst = y-dest_area.vlength*default_block_size;
			areas[cardinal.north] = dest_area;
			break;
	}
	
	dest_area.x = xst;
	dest_area.y = yst;
		
	room_build(dest_area, obj_control.seed_group, default_block_size, wall_passage_width);
	
	return dest_area;
}