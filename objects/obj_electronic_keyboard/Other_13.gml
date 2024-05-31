/// @description play score note

var session = sheet_music.piano_score[score_index]
var session_end_reached = ++score_current_note_index == array_length(session)

if (session_end_reached) {
	score_current_note_index = -1
	auto_playing = false
	player_can_play = true
	
	return
}

var current_note_data = session[score_current_note_index]
last_key_pressed = current_note_data[0]
key = last_key_pressed

var period = sheet_music.tempo * current_note_data[1]

audio_play_sound(synth_sounds[key], 10, false)

time_source_reconfigure(ts_play_score_note, period, time_source_units_frames, function() {
	event_user(3)
})

time_source_start(ts_play_score_note)