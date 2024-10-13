/// @description unload synth

array_foreach(synth_sounds, function(snd) {
	var result = audio_destroy_stream(snd)	
})

synth_sounds = undefined