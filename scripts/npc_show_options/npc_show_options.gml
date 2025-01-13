function npc_show_options(npc) {
	with (npc) {
		if (array_length(options_menu) == 0) {
			options_menu = ui_create_menu(
				0, 
				0,
				options, 
				global.npc_options_stylesheet, 
				pawpr_align.at_center, 
				pawpr_align.at_center
			)
		}
	}
	
	obj_npc_control.npc_options = npc
}