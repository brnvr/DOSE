array_foreach(instances, function(instance, i) {
	area_destroy_instance(id, instance)
})

time_source_destroy(ts_on_built)