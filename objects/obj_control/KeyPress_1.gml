/// @description check cheat codes

if (check_cheat("thisside")) {
	goto_thisside()		
}

if (check_cheat("otherside")) {
	goto_otherside()		
}

if (check_cheat("longlegs")) {
	obj_player.RUN_SPEED = 25	
}

if (check_cheat("spiderbyte")) {
	obj_player.get_envenomated()	
}