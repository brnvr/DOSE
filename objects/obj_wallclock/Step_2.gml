if (parent_wall != noone && instance_exists(parent_wall)) {
	var texture_index_in_wall = array_find_index(parent_wall.texture_list, function(tex) {
		return tex == texture;
	});
		
	texture = sprite_get_texture(obj_wallclock_control.sprite_index, 0);
	parent_wall.texture_list[texture_index_in_wall] = texture;
}