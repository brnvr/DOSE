/// @description Set custom areas

global.custom_areas[ca.entrance_hall] = actor_3d_create(0, 0, 0, obj_custom_area, {
	layer_name: "EntranceHall"	
})

global.custom_areas[ca.players_room] = actor_3d_create(0, 0, 0, obj_custom_area, {
	layer_name: "PlayersRoom",
	main_door: inst_players_room_door
})

global.custom_areas_door_numbers = array_create(999, -1)
global.custom_areas_door_numbers[door_number_destination] = global.custom_areas[ca.players_room]