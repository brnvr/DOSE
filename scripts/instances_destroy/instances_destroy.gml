function instances_destroy(instances_arr) {
	array_foreach(instances_arr, function(instance) {
		instance_destroy(instance);
	});
}