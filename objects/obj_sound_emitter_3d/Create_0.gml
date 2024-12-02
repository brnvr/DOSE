emitter = audio_emitter_create();
//audio_bus = audio_bus_create()
//audio_bus.effects[0] = audio_effect_create(AudioEffectType.Reverb1, { mix:0.25, size:0.5} )

audio_emitter_falloff(emitter, falloff_ref_dist, falloff_max_dist, falloff_factor);
//audio_emitter_bus(emitter, audio_bus)

zprevious = z

sound_id = noone

if (play_at_creation) {
	sound_emitter_3d_play(id)
}