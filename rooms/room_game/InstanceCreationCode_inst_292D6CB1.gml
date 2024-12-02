on_interact = function() {
	if (!audio_is_playing(snd_uncertain)) {
		game_set_music_track(snd_uncertain, .8)
	}
	
	door_random_on_interact(id)
}