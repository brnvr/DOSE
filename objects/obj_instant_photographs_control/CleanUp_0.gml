array_foreach(photographs, function(photograph) {
	sprite_delete(photograph)	
})

obj_player.can_move = true
obj_player.can_look = true
obj_player.can_interact = true

cursor_center()
cursor_set_sprite(interactable_get_hover_sprite(obj_player.actor_hover))
cursor_pause_sync(1)