revert_hint = false;
on_interact = staircase_on_interact;

if (other_end != noone) {
	other_end.other_end = id;	
}

if (dir == stairs_directions.up) {
	vbuff_list = [vb_load("3d models/staircase_up.buf", false)];
} else {
	vbuff_list = [vb_load("3d models/staircase_down.buf", false)];
}

event_inherited();