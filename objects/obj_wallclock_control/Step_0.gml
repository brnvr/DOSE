/*var clock_index = array_find_index(obj_control.current_area.instances, function(item) {
	if (!instance_exists(item)) return false;
	return item.object_index == obj_wallclock;
});*/


	if (obj_control.fog_end == 1300) {
		event_user(1);
	} else {
		event_user(0);
	}
	
	if (changed) {
		var surface;
	
		surface = surface_create(512, 512);
	
		surface_set_target(surface);
		draw_clear_alpha(c_black, 0);
		draw_sprite(spr_wallclock, 0, clock_xpos, clock_ypos);
		draw_sprite_ext(spr_wallclock, 1, clock_xpos, clock_ypos, 1, 1, -seconds_angle, c_white, 1);
		draw_sprite_ext(spr_wallclock, 2, clock_xpos, clock_ypos, 1, 1, -minutes_angle, c_white, 1);
		draw_sprite_ext(spr_wallclock, 3, clock_xpos, clock_ypos, 1, 1, -hours_angle, c_white, 1);
		surface_reset_target();
		
		if (sprite_index >= 0) {
			sprite_delete(sprite_index);
		}
		
		sprite_index = sprite_create_from_surface(surface, 0, 0, texture_size, texture_size, false, false, 0, 0);
	
		surface_free(surface);	
	}


