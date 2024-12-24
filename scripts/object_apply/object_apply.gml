function object_apply(obj, callback) {
	var n_objs = instance_number(obj)
	
	for (var i = 0; i < n_objs; i++) {
		var inst = instance_find(obj, i)
		
		callback(inst, i)
	}
}