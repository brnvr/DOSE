if (audio_emitter_exists(emitter)) {
	audio_emitter_free(emitter)
	espeak_buffer_free_sound(sound)
}