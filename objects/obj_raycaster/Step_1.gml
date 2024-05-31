if (__is_started__) {
	if (__iteration__ == 0) {
		callback(__instance_collided__);
		__update__();
	}
	
	__raycast__();
} 