if (variable_instance_exists(id, "background")) {
	draw_sprite(background, 0, 0, 0);	
}

draw_set_color(c_black);
draw_set_alpha(0.35);

draw_rectangle(0, 0, screen_width, screen_height, false);

draw_set_alpha(1);
draw_set_color(c_white);

ui_draw(menu);