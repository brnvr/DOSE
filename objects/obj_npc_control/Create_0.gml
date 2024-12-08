npc_speaking = noone
is_npc_speaking = false
ts_continue_dialogue = time_source_create(
	time_source_global,
	0.5,
	time_source_units_seconds,
	function() {
		if (array_length(npc_speaking.dialogue) == 0) {
			npc_speaking.dialogue = npc_speaking.secondary_dialogue
			npc_speaking.on_finish_talking()
			release_player()
			npc_speaking.keep_focus = false
		} else {
			npc_speak(npc_speaking)	
		}
	}
)

release_player = function() {
	if (npc_speaking.keep_focus) {
		obj_player.can_move = true
		obj_player.can_interact = true
		obj_player.focus = noone
	}	
}