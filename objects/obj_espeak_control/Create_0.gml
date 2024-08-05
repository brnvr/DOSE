espeak_buffer = espeak_buffer_create()
//audio_buffer = noone
npc_current = noone
//sound_3d = instance_create_layer(0, 0, "Abstract", obj_sound_3d)
audio_bus_main.effects[0] = audio_effect_create(AudioEffectType.Reverb1, { mix:0.25, size:0.5} )