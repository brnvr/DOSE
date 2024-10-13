function pawpr_is_mouse_over(element) {
	var bounding_rect = pawpr_element_get_bounding_rect(element);
	
	return point_in_rectangle(window_mouse_get_x(), window_mouse_get_y(), bounding_rect[pawpr_rect.left]+1, bounding_rect[pawpr_rect.top]+1, bounding_rect[pawpr_rect.right], bounding_rect[pawpr_rect.bottom]);
}