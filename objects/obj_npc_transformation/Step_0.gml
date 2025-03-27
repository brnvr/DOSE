count--

if (!is_blinking) {
	var prob_blink = ((max_count-count)/max_count)/4

	var blink = random_event(prob_blink == 1 ? .999 : prob_blink)

	if (blink) {
		npc.sprite_index = npc_other_sprite
		time_source_start(ts_blink)
		is_blinking = true
	}
}

if (count <= 0) {
	npc_other.visible = true
	npc_other.is_transforming = false
	instance_destroy(npc)
	instance_destroy()
}