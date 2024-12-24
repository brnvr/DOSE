function interactable_is_in_view(actor, left_offset = 0, top_offset = 0, right_offset = -1, bottom_offset = -1, view_id=0) {
	var pos_2d = position_3d_get_projected(actor.x, actor.y, actor.z - actor.height/2, view_id)
	
	if (is_undefined(pos_2d)) {
		return false	
	}

	return	pos_2d[0] >= left_offset &&
			(right_offset == -1 || pos_2d[0] <= view_get_wport(view_id) - right_offset) &&
			pos_2d[1] >= top_offset &&
			(bottom_offset == -1 || pos_2d[1] <= view_get_hport(view_id) - bottom_offset)
}