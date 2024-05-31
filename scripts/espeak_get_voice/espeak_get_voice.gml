function espeak_get_voice() {
	var str_voice, arr_voice, hash_pos;
	
	str_voice = string_replace_all(espeakGM_GetVoice(), "\n", " ");
	arr_voice = string_split(str_voice, " ");

	hash_pos = string_pos("\\", arr_voice[0]);
	
	if (hash_pos > 0) {
		arr_voice[0] = string_copy(arr_voice[0], hash_pos+1, string_length(arr_voice[0])-hash_pos);
	}

	return arr_voice;
}