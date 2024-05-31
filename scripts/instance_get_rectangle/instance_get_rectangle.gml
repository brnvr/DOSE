function instance_get_rectangle(x0, y0, x1, y1, obj, not_me=false) {
	var arr_instances;
	
	arr_instances = [];
	
	with(obj) {
		if (point_in_rectangle(x, y, x0, y0, x1, y1)) {
			var add_instance = true;
			
			if (not_me) {
				if (id == other.id) add_instance = false;
			}
			
			if (add_instance) array_push(arr_instances, id);	
		}
	}
	
	return arr_instances;
}