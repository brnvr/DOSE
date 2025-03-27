function npc_speak(npc, display_caption=true, interrupt_current_dialogue=false) {
	
	show_debug_message(npc.dialogue)
	if (audio_is_playing(npc.sound_emitter.sound)) {
		if (interrupt_current_dialogue) {
			sound_emitter_3d_stop(npc.sound_emitter)	
		} else {
			return false
		}
	}
	show_debug_message(npc.dialogue)
	
	if (obj_npc_control.is_npc_speaking && obj_npc_control.npc_speaking != noone) {
		audio_stop_sound(obj_npc_control.npc_speaking.sound_emitter.sound)
		
		obj_npc_control.npc_speaking = noone
		obj_npc_control.is_npc_speaking = false
	}
	
	var caption = is_array(npc.dialogue) ? npc.dialogue[0] : npc.dialogue
	
	if (caption == "") {
		return false
	}
	
	if (caption == "...") {
		if (display_caption) {
			obj_hud.show_caption(caption, true, 90)
		}
		return false
	}
	
	espeak_set_voice(npc.voice_source + (string_length(npc.voice_variant) == 0 ? "" : $"+{npc.voice_variant}"))
	espeak_set_rate(npc.voice_speed)
	espeak_set_pitch(npc.voice_pitch)
	espeak_set_range(npc.voice_range)
	
	if (display_caption) {
		obj_npc_control.npc_speaking = npc
		obj_hud.show_caption(caption)	
	}
	
	obj_espeak_control.npc_current = npc
	
	espeak_synth(npc.espeak_buffer, caption)
	
	return true
}