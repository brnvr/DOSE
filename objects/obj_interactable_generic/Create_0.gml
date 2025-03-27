interactions_list = interactions_list ?? []

if (display_name == "") {
	display_name = variable_static_get(object_index, "name")	
}

event_inherited()