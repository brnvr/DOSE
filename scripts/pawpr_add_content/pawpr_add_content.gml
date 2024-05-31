function pawpr_add_content(ui, element_params) {
	if (!is_array(ui[pawpr_attr.content])) {
		throw "Invalid type of element.";	
	}
	array_push(ui[pawpr_attr.content], pawpr_element(element_params));
}