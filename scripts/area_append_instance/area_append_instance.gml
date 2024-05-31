function area_append_instance(area, inst) {
	inst.parent_area = area;
	array_push(area.instances, inst);		
}
