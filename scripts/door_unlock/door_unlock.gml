function door_unlock(door, key) {
	obj_player.inventory_remove_item(key)
	door.locked = false
	obj_hud.add_message("Unlocked")
	audio_play_sound(snd_lock_unlock_door, false, false)
}