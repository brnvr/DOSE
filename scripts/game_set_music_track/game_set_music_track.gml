function game_set_music_track(sound_id, gain=1, fade_time=4000) {
	if (sound_id == obj_control.music_track) return;
	
	if (obj_control.music_track != -1) {
		audio_sound_gain(obj_control.music_track, 0, fade_time);
		
		if (obj_control.music_track_previous != -1 && time_source_get_state(obj_control.ts_stop_music_track) == time_source_state_active) {
			audio_stop_sound(obj_control.music_track_previous);	
		}
		
		obj_control.music_track_previous = obj_control.music_track;
		
		time_source_reconfigure(obj_control.ts_stop_music_track, fade_time/1000, time_source_units_seconds, function() {
			audio_stop_sound(obj_control.music_track_previous);
		});
		
		time_source_start(obj_control.ts_stop_music_track);
	}
	
	if (sound_id != -1) {
		audio_sound_gain(sound_id, .2, 0);
		audio_play_sound(sound_id, 10, true);
		audio_sound_gain(sound_id, gain, fade_time);
	}
	
	obj_control.music_track = sound_id;
}