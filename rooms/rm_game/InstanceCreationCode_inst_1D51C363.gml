keep_focus = true
	
dialogue = [
	"Good evening, sir, and welcome to your new home.",
	"As a tradition with the residents of this building, we will all engage in a little \"treasure hunt\" game.",
	"It plays like this: you must find your room, but we will not tell you where it is. We may give you hints, if you ask.",
	"Sometimes, you might need to accomplish little challenges to earn those hints.",
	"It will be a fun way to get to know your new neightbors.",
	"Here is the key to the hallways. I hope you enjoy the game, sir."
]
		
on_finish_talking = function() {
	var key = area_add_actor_3d(obj_game_control.current_area, 0, 0, 0, obj_key_0)
	
	obj_player.pick_item(key)
}