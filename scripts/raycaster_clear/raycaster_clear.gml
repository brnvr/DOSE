function raycaster_clear(raycaster) {
	raycaster.__iteration__ = 0;
	raycaster.__instance_collided__ = noone;
}