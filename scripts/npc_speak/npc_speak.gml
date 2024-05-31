function npc_speak(npc, show_subtitle=true, end_conversation=true) {
	if (audio_is_playing(obj_espeak_control.audio_buffer)) {
		return false
	}
	
	var speech = npc.dialogue
	
	if (speech == "") {
		return false
	}
	
	if (speech == "...") {
		if (show_subtitle) {
			obj_hud.show_speech(speech, true, 90)
		}
		return false
	}
	
	espeak_set_voice(npc.voice_source + (string_length(npc.voice_variant) == 0 ? "" : $"+{npc.voice_variant}"))
	espeak_set_rate(npc.voice_speed)
	espeak_set_pitch(npc.voice_pitch)
	espeak_set_range(npc.voice_range)
	espeak_synth(obj_espeak_control.espeak_buffer, speech)
	
	if (show_subtitle) {
		obj_hud.show_speech(speech)	
	}
	
	obj_espeak_control.sound_3d.x = npc.x
	obj_espeak_control.sound_3d.y = npc.y
	obj_espeak_control.sound_3d.z = npc.z - default_block_size/2
	
	if (end_conversation) {
		//npc.dialogue = "..."	
	}
	
	return true
}