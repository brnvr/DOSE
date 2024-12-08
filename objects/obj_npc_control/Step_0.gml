if (!instance_exists(npc_speaking)) {
	npc_speaking = noone	
}

if (npc_speaking != noone && obj_hud.caption != "" && audio_is_playing(npc_speaking.sound_emitter.sound)) {
	is_npc_speaking = true
}

if (is_npc_speaking && (npc_speaking == noone || (npc_speaking != noone && !audio_is_playing(npc_speaking.sound_emitter.sound)))) {
	is_npc_speaking = false
	obj_hud.caption = ""
	
	if (npc_speaking != noone) {
		if (is_array(npc_speaking.dialogue)) {
			array_shift(npc_speaking.dialogue)
			time_source_start(ts_continue_dialogue)
		} else {
			release_player()
			npc_speaking.on_finish_talking()
		}
	}
}