photographs = noone

on_select = function() {
	photographs = instance_create_layer(0, 0, "Abstract", obj_instant_photographs_control)
}

on_unselect = function() {
	if (photographs != noone) {
		instance_destroy(photographs)
	}
}

quantity = photo_count

event_inherited();

