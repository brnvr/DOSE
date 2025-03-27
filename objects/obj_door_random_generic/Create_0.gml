revert_task = false
revert_task_opposite_area = noone
has_been_opened = false
on_interact = function() {
	door_random_on_interact(id)	
}
texture_list = [sprite_get_texture(sprite_index, 0)]

on_hover = function() {
	if (obj_control.current_area.object_index == obj_corridor) {
		if (door_number > 0) {
			display_name = $"door {door_number}"
		}
	} else {
		display_name = "door"
	}	
}

if (numbered && number_side != -1) {
	door_generate_number(id, undefined)
}

event_inherited()

