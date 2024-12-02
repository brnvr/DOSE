alpha += spd

if (alpha >= 1) {
	on_completed()
	
	if (auto_destroy) {
		instance_destroy();
	}
}