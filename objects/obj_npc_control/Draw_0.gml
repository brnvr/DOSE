if (view_current == views.view_2d && npc_options != noone) {
	with (npc_options) {	
		if (array_length(options_menu) > 0) {
			pawpr_draw(options_menu)	
		}	
	}	
}