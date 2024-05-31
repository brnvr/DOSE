audio_buffer = espeak_buffer_get_sound(espeak_buffer);
audio_bus_main.effects[0] = audio_effect_create(AudioEffectType.Reverb1, { mix:0.25, size:0.5} );

sound_3d.sound = audio_buffer

sound_3d_play(sound_3d)