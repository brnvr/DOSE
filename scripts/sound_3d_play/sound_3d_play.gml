function sound_3d_play(sound_3d) {
	with(sound_3d) {
		audio_play_sound_on(emitter, sound, loops, priority);	
	}
}