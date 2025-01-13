parent_wall = noone

init_from_wall = function(wall) {
	zrotation = wall.zrotation
	
	var zrotation_sin = dsin(zrotation)
	var zrotation_cos = dcos(zrotation)
	
	x = wall.x - zrotation_cos * 1.1 + zrotation_sin * (default_block_size / 2 - xscale)
	y = wall.y + zrotation_sin * 1.1 + zrotation_cos * (default_block_size / 2 - xscale)
}

angle = 0

event_inherited()