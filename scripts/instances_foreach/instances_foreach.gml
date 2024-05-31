function instances_foreach(object, callback) {
	var l = instance_number(object);
	
	for(var i = 0; i < l; i++) {
		var inst = instance_find(object, i);
		
		callback(inst)
	}
}