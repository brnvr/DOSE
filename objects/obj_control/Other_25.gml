/// @description Set custom areas

custom_areas[ca.entrance_hall] = actor_3d_create(0, 0, 0, obj_custom_area, {
	layer_name: "EntranceHall"	
})

custom_areas[ca.players_room] = actor_3d_create(0, 0, 0, obj_custom_area, {
	layer_name: "PlayersRoom",
	main_door: inst_players_room_door
})

custom_areas_door_numbers = array_create(999, -1)
custom_areas_door_numbers[door_number_destination] = custom_areas[ca.players_room]