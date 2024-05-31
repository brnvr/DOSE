/// @description load synth

var notes = ["C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb", "B"]

synth_sounds = []

for (var octave = 1; octave <= 4; octave++) {
	var ctx = {
		synth: synth,
		octave: octave,
		synth_sounds: synth_sounds
	}
	
	array_foreach(notes, method(ctx, function(note) {
		var path = $"synths/{synth}/{note}{octave}.ogg"
		var snd = audio_create_stream(path)
		
		array_push(synth_sounds, snd)
	}))
}