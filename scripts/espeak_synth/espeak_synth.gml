function espeak_synth(buffer, text, position = 0, end_position = 0) {
	if (espeakGM_GetSoundId() == buffer) {
		return;
	}
	
	buffer_resize(buffer, 0);
	espeakGM_Synth(buffer, text, position, end_position);
}