var door_width, door_xstart;

door_width = (default_block_size-2*wall_passage_width)/default_block_size;
door_xstart = wall_passage_width/default_block_size;

globalvar	vbuff_wall,
			vbuff_plane_distorted,
			vbuff_door,
			vbuff_door_mirrored,
			vbuff_billboard,
			vbuff_wall_black,
			vbuff_door_black,
			vbuff_floor,
			bbox_wall,
			bbox_door,
			bbox_floor,
			bbox_wall_passage_left,
			bbox_wall_passage_right;

vbuff_wall = vb_create_quad([0, 0, -1], [0, 1, -1], [0, 1, 0], [0, 0, 0], -1, 0, 0, c_white, 1, 0, 0, 1, 1, vertex_format)
vbuff_plane_distorted = vb_create_quad([0, .2, -1], [0, .8, -1], [0, .8, 0], [0, .2, 0], -1, 0, 0, c_white, 1, 0, 0, 1, 1, vertex_format)
vbuff_door = vb_create_quad([0, -.07, -1], [0, door_width+.07, -1], [0, door_width, 0], [0, 0, 0], -1, 0, 0, c_white, 1, door_xstart, 0, door_width, 1, vertex_format);
vbuff_door_mirrored = vb_create_quad([0, door_width+.07, -1], [0, -.07, -1], [0, 0, 0], [0, door_width, 0], -1, 0, 0, c_white, 1, door_xstart, 0, door_width, 1, vertex_format);
vbuff_billboard = vb_create_quad([0, -.5, -1], [0, .5, -1], [0, .5, 0], [0, -.5, 0], -1, 0, 0, c_white, 1, 0, 0, 1, 1, vertex_format);
vbuff_wall_black = vb_create_quad([0, 0, -1], [0, 1, -1], [0, 1, 0], [0, 0, 0], -1, 0, 0, c_black, 1, 0, 0, 1, 1, vertex_format);
vbuff_door_black = vb_create_quad([0, -.07, -1], [0, door_width+.07, -1], [0, door_width, 0], [0, 0, 0], -1, 0, 0, c_black, 1, door_xstart, 0, door_width, 1, vertex_format);
vbuff_floor = vb_create_quad([0, 0, 0], [1, 0, 0], [1, 1, 0], [0, 1, 0], 0, 0, -1, c_white, 1, 0, 0, 1, 1, vertex_format);

bbox_wall = bbox_create(-4/64, 0, -1, 4/64, 1, 0);
bbox_door = bbox_create(-4/64, 0, -135/64, 4/64, 96/256, 0);
bbox_wall_passage_left = bbox_create(-4/64, 0, -1, 4/64, 20/64, 0);
bbox_wall_passage_right = bbox_create(-4/64, 1-20/64, -1, 4/64, 1, 0);
bbox_floor = bbox_create(0, 0, -2/64, 1, 1, 2/64);


