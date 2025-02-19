orientation = cardinal_get_orientation(get_cardinal_direction(zrotation))

if (is_undefined(on_interact)) {
	on_interact = function() {
		if (locked) {
			if (!audio_is_playing(sound_locked)) {
				obj_hud.add_message("Locked")
			
				var snd_locked = instance_create_layer(x, y, "Abstract", obj_sound_emitter_3d, {
					z,
					sound: sound_locked,
					play_at_creation: true,
					destroy_after_playing: true
				})	
			}
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

snd_open = instance_create_layer(x, y, "Abstract", obj_sound_emitter_3d, {
	z,
	sound: sound_open
})

snd_close = instance_create_layer(x, y, "Abstract", obj_sound_emitter_3d, {
	z,
	sound: sound_close
})

event_inherited();