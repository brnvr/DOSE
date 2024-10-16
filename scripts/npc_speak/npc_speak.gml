function npc_speak(npc, show_subtitle=true, end_conversation=true) {
	if (audio_is_playing(npc.sound_3d.sound)) {
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
	
	if (show_subtitle) {
		obj_hud.npc_speaking = npc
		obj_hud.show_speech(speech)	
	}
	
	obj_espeak_control.npc_current = npc
	
	if (end_conversation) {
		//npc.dialogue = "..."	
	}
	
	espeak_synth(npc.espeak_buffer, speech)
	
	return true
}