function interactable_get_hover_sprite(interactable) {
	if (interactable == noone) return spr_cursor_point;
	
	if (interactable.active) {
		if (interactable.custom_cursor != noone) {
			return interactable.custom_cursor;	
		}
		
		switch (interactable.interaction_default) {
			case interactions.pick:
				return spr_cursor_hand;
				
			case interactions.use:
				return spr_cursor_hand;
			
			case interactions.talk:
				return spr_cursor_balloon;
		}
	}
	
	return spr_cursor_point;
}