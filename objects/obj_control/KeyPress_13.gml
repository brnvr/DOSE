var fullscreen;

fullscreen = !window_get_fullscreen();

window_set_fullscreen(fullscreen);
application_resize(aspect_ratio);
view_set_wport(views.view_3d, screen_width);
view_set_hport(views.view_3d, screen_height);
view_set_wport(views.view_2d, screen_width);
view_set_hport(views.view_2d, screen_height);
	
with(obj_hud) {
	event_user(0);
	event_user(1);
}