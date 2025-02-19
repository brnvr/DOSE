/// @description check if sound is playing

if (sound_id != noone) {
	if (!audio_is_playing(sound_id)) {
		instance_destroy()
	}
}

alarm[0] = 5