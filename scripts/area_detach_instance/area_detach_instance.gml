function area_detach_instance(area, instance) {
	if (!array_remove(area.instances, instance)) {
		throw $"Instance {instance} not found in area {area}.";
	}
}