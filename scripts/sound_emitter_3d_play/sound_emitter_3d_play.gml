function sound_emitter_3d_play(sound_emitter) {
	with(sound_emitter) {
		sound_id = audio_play_sound_on(emitter, sound, loops, priority)
	}
}