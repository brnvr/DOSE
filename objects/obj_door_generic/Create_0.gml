orientation = cardinal_get_orientation(get_cardinal_direction(zrotation))

if (is_undefined(on_interact)) {
	on_interact = function() {
		if (locked) {
			obj_hud.show_speech("Locked.", true);
		}
	}
}

if (is_struct(areas)) {
	var areas_arr = [];
	
	areas_arr[cardinal.north] = variable_struct_get(areas, "north") ?? noone;
	areas_arr[cardinal.south] = variable_struct_get(areas, "south") ?? noone;
	areas_arr[cardinal.west] = variable_struct_get(areas, "west") ?? noone;
	areas_arr[cardinal.east] = variable_struct_get(areas, "east") ?? noone;
	
	areas = areas_arr;
}

event_inherited();