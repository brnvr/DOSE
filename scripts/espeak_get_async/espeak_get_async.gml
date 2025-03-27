function espeak_get_async(event_user_id) {
	var buffer = async_load[? "espeak_buffer_id"]
	var audio_base64 = async_load[? "espeak_wave"]
	var synth_ended = async_load[? "espeak_synth_ended"]

	if (!is_undefined(audio_base64)) {
		var buffer_size, buffer64, buffer64_size
	
		buffer64 = buffer_base64_decode(audio_base64)
		buffer64_size = buffer_get_size(buffer64)
		buffer_size = buffer_get_size(buffer)
		buffer_resize(buffer, buffer_size + buffer64_size)
	
		buffer_copy(buffer64, 0, buffer64_size, buffer, buffer_size)
	}
	
	if (!is_undefined(synth_ended)) {
		event_user(event_user_id)
	}
}