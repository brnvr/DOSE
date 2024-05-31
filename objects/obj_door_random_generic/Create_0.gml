revert_hint = false
revert_hint_opposite_area = noone
has_been_opened = false
on_interact = door_random_on_interact
texture_list = [sprite_get_texture(sprite_index, 0)]

on_hover = function() {
	if (obj_control.current_area.object_index == obj_corridor) {
			if (door_number > 0) {
				name = $"door {door_number}"
			}
		} else {
			name = "door"
	}	
}

if (number_side != -1) {
	door_generate_number(undefined)
}

event_inherited()

