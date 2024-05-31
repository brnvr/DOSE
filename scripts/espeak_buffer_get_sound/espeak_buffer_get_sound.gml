function espeak_buffer_get_sound(espeak_buffer) {
	var voice, mbrola
	
	voice = espeak_get_voice()
	mbrola = string_starts_with(voice[0], "mb-")
	
	return audio_create_buffer_sound(espeak_buffer, buffer_s16, mbrola ? 16000 : 22500, 0, buffer_get_size(espeak_buffer), audio_mono);
}