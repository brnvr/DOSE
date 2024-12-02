alpha -= spd;

if (alpha <= 0) {
	on_completed()
	
	if (auto_destroy) {
		instance_destroy();
	}
}