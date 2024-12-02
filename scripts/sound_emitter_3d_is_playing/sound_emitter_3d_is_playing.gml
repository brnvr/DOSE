function sound_emitter_3d_is_playing(sound_emitter) {
	return sound_emitter.sound_id != noone && audio_is_playing(sound_emitter.sound_id)
}