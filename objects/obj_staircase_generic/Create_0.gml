revert_task = false
on_interact = function() {
	staircase_on_interact(id)	
}

if (other_end != noone) {
	other_end.other_end = id;
}

if (dir == stairs_directions.up) {
	vbuff_list = [vb_load("3d_models/staircase_up.buf", false)]
} else {
	vbuff_list = [vb_load("3d_models/staircase_down.buf", false)]
}

event_inherited()