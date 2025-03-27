function sound_emitter_3d_stop(sound_emitter) {
	with(sound_emitter) {
		audio_stop_sound(sound_emitter.sound)
		sound_emitter.sound_id = noone
	}
}