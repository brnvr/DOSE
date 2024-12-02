function sound_emitter_3d_pause(sound_emitter) {
	with(sound_emitter) {
		audio_pause_sound(sound_emitter.sound)
		sound_emitter.sound_id = noone
	}
}