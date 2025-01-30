sound_emitter = instance_create_layer(x, y, "Abstract", obj_sound_emitter_3d, {
	sound: snd_clock_tick	
})

init_from_wall = function(wall) {
	zrotation = wall.zrotation
	
	var zrotation_sin = dsin(zrotation)
	var zrotation_cos = dcos(zrotation)
	
	x = wall.x - zrotation_cos + zrotation_sin * (default_block_size / 2)
	y = wall.y + zrotation_sin + zrotation_cos * (default_block_size / 2)
}

angle = 0

event_inherited()