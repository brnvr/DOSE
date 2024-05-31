alpha -= spd;

if (alpha <= 0) {
	if (!is_undefined(on_completed)) {
		on_completed();
	}
	
	if (auto_destroy) {
		instance_destroy();	
	}
}