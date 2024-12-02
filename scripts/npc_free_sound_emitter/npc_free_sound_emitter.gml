function npc_free_sound_emitter(npc) {
	if (npc.sound_emitter.sound != noone) {
		audio_free_buffer_sound(npc.sound_emitter.sound)	
	}
}