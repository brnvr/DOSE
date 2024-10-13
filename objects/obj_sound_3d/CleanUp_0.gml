if (audio_emitter_exists(emitter)) {
	audio_emitter_free(emitter)
	audio_free_buffer_sound(sound)
}