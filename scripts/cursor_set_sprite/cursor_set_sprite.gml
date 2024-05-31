function cursor_set_sprite(spr_cursor, scale=1, alpha=1, enabled=true, xoffset=0, yoffset=0, rotation=0) {
	obj_cursor.sprite_index = spr_cursor;
	obj_cursor.scale = scale;
	obj_cursor.alpha = alpha;
	obj_cursor.enabled = enabled;
	obj_cursor.xoffset = xoffset;
	obj_cursor.yoffset = yoffset;
	obj_cursor.rotation = rotation;
}