interactions_list = interactions_list ?? []

on_interact = function() {
	if (!audio_is_playing(snd_uncertain)) {
		game_set_music_track(snd_uncertain, obj_settings.music_volume * .8)
	}
	
	door_random_on_interact(id)
}

array_push(interactions_list, [obj_key_0, function() {
	door_unlock(id, obj_key_0)
}])
