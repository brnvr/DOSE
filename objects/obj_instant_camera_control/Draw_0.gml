if (view_current == views.view_2d) {
	draw_sprite_ext(spr_instant_camera_view, 0, 0, 0, 9, 9, 0, c_white, 1)
}

draw_set_color(c_black)
draw_set_alpha(1)

draw_rectangle(-130, -130-shutter_yoffset, 130, 130-shutter_yoffset, false)