audio_free_buffer_sound(npc_current.sound_3d.sound)
npc_current.sound_3d.sound = espeak_buffer_get_sound(npc_current.espeak_buffer)

sound_3d_play(npc_current.sound_3d)