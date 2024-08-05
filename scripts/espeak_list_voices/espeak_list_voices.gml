function espeak_list_voices() {
	var str_voices, arr_voices, n_voices, arr_result;

	str_voices = string_replace_all(espeakGM_ListVoices(), "\n", " ");	
	arr_voices = string_split(str_voices, ", ");
	n_voices = array_length(arr_voices);
	arr_result = [];

	for (var i = 0; i < n_voices; i++) {
		var arr_voice = string_split(arr_voices[i], " ")
		var hash_pos = string_pos("\\", arr_voice[0]);
	
		if (hash_pos > 0) {
			arr_voice[0] = string_copy(arr_voice[0], hash_pos+1, string_length(arr_voice[0])-hash_pos);
		}
	
		array_push(arr_result, arr_voice);	
	}

	return arr_result;
}