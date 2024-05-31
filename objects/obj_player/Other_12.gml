/// @description interaction

if (focus == noone) {
	if (instance_exists(actor_hover)) {
		if (inventory_item_selected == noone) {
			cursor_set_sprite(interactable_get_hover_sprite(actor_hover));
		}
	
		if (actor_hover != noone && actor_hover.active) {
			if (inventory_item_selected == noone) {
				actor_hover.on_hover()
				
				switch (actor_hover.interaction_default) {
					case interactions.look:
						break;
			
					case interactions.pick:
						mouse_click(mb_left, function() {
							pick_item(actor_hover)
						});
						break;
			
					case interactions.talk:
						mouse_click(mb_left, function() {
							talk_to(actor_hover)
						});
						break;
					
					case interactions.use:
						mouse_click (mb_left, function() {
							actor_hover.on_interact();
						});
						break;
					
					case interactions.custom:
						mouse_click (mb_left, function() {
							actor_hover.on_interact();
						});
						break;
				}
			} else if (inventory_item_selected_enabled) {
				mouse_click(mb_left, function() {
					interactable_interact_with(actor_hover, inventory_item_selected.object, function() {
						cursor_set_to_item_selected(false, 5);
					});
				});
			}
		}
	} else {
		if (inventory_item_selected == noone) {
			cursor_set_sprite(interactable_get_hover_sprite(noone));
		}
	}
}