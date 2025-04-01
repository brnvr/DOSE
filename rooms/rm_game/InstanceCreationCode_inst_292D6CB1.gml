on_interact = function() {
	if (!audio_is_playing(snd_umc_uncertain)) {
		game_set_music_track(snd_umc_uncertain, obj_settings.music_volume * .8)
	}
	
	door_random_on_interact(id)
}

interactable_set_interaction(id, obj_key_0, function() {
	door_unlock(id, obj_key_0)
})