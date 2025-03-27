#macro ev_very_common 50
#macro ev_common 40
#macro ev_regular 30
#macro ev_rare 20
#macro ev_very_rare 10
#macro ev_anomaly 1

#macro aspect_ratio 16/9
#macro default_block_size 256
#macro wall_passage_width 80
#macro door_order_length 5

#macro instant_photograph_width 200
#macro instant_photograph_height 200

#macro game_view_x 16
#macro game_view_y 16
#macro game_view_width 512
#macro game_view_height 288
#macro game_view_center_x (game_view_x + game_view_width*.5)
#macro game_view_center_y (game_view_y + game_view_height*.5)

#macro c_dkblue make_color_rgb(0, 0, 85)
#macro c_blanched_almond make_color_rgb(255, 235, 205)
#macro c_ltgreen make_color_rgb(66, 245, 114)
#macro c_black_1 make_color_rgb(5, 9, 20)
#macro c_dark_maroon make_color_rgb(17, 5, 36)
#macro c_eggplant make_color_rgb(59, 6, 58)
#macro c_purple_wine make_color_rgb(105, 23, 73)
#macro c_dark_crimson make_color_rgb(156, 50, 71)
#macro c_terra_cotta make_color_rgb(212, 100, 83)
#macro c_sandy_orange make_color_rgb(245, 161, 93)
#macro c_peach_tint make_color_rgb(255, 207, 142)
#macro c_bright_coral make_color_rgb(255, 122, 125)
#macro c_hot_pink make_color_rgb(255, 65, 125)
#macro c_vivid_magenta make_color_rgb(214, 26, 136)
#macro c_deep_magenta make_color_rgb(148, 0, 122)
#macro c_plum make_color_rgb(66, 0, 78)
#macro c_wine_black make_color_rgb(34, 0, 41)
#macro c_midnight_purple make_color_rgb(16, 7, 38)
#macro c_royal_maroon make_color_rgb(37, 8, 44)
#macro c_dusk_rose make_color_rgb(61, 17, 50)
#macro c_ruby_red make_color_rgb(115, 38, 61)
#macro c_crimson make_color_rgb(189, 64, 53)
#macro c_tangerine make_color_rgb(237, 123, 57)
#macro c_orange_glow make_color_rgb(255, 184, 74)
#macro c_bright_yellow make_color_rgb(255, 245, 64)
#macro c_chartreuse make_color_rgb(198, 216, 49)
#macro c_grass_green make_color_rgb(119, 176, 42)
#macro c_forest_green make_color_rgb(66, 144, 88)
#macro c_teal make_color_rgb(44, 100, 94)
#macro c_deep_sea make_color_rgb(21, 60, 74)
#macro c_ocean_blue make_color_rgb(5, 33, 55)
#macro c_dark_navy make_color_rgb(14, 4, 33)
#macro c_midnight_blue make_color_rgb(12, 11, 66)
#macro c_royal_blue make_color_rgb(3, 39, 105)
#macro c_sky_blue make_color_rgb(20, 68, 145)
#macro c_bright_blue make_color_rgb(72, 139, 212)
#macro c_light_cyan make_color_rgb(120, 215, 255)
#macro c_aqua make_color_rgb(176, 255, 241)
#macro c_almost_white make_color_rgb(250, 255, 255)
#macro c_light_gray_blue make_color_rgb(199, 212, 225)
#macro c_slate_blue make_color_rgb(146, 143, 184)
#macro c_deep_purple make_color_rgb(91, 83, 125)
#macro c_iris make_color_rgb(57, 41, 70)
#macro c_dark_iris make_color_rgb(36, 20, 44)
#macro c_midnight_iris make_color_rgb(14, 15, 44)
#macro c_dark_ocean make_color_rgb(19, 34, 67)
#macro c_dark_teal make_color_rgb(26, 70, 107)
#macro c_cyan make_color_rgb(16, 144, 142)
#macro c_turquoise make_color_rgb(40, 192, 116)
#macro c_lime_green make_color_rgb(61, 255, 110)
#macro c_pastel_yellow make_color_rgb(248, 255, 184)
#macro c_sandstone make_color_rgb(240, 194, 151)
#macro c_soft_coral make_color_rgb(207, 150, 140)
#macro c_dusty_rose make_color_rgb(143, 87, 101)
#macro c_grape make_color_rgb(82, 41, 75)
#macro c_deep_night make_color_rgb(15, 2, 46)
#macro c_burgundy make_color_rgb(53, 0, 59)
#macro c_dark_fuchsia make_color_rgb(100, 0, 76)
#macro c_bright_ruby make_color_rgb(155, 14, 62)
#macro c_cherry_red make_color_rgb(212, 30, 60)
#macro c_bright_orange make_color_rgb(237, 76, 64)
#macro c_autumn_orange make_color_rgb(255, 151, 87)
#macro c_dark_orange make_color_rgb(212, 102, 47)
#macro c_brown_red make_color_rgb(156, 52, 26)
#macro c_burgundy_black make_color_rgb(105, 27, 34)
#macro c_dark_burgundy make_color_rgb(69, 12, 40)
#macro c_deep_wine make_color_rgb(45, 0, 46)

#macro pron_masculine ["he", "him"]
#macro pron_feminine ["she", "her"]

enum views {
	view_3d,
	view_2d
}

enum pronoun_type {
	subject,
	object
}

enum axis {
	x0, y0, z0,
	x1, y1, z1,
	x2, y2, z2	
}

enum mb_actions {
	press, hold, release	
}

enum interactions {
	look,
	pick,
	talk,
	use,
	custom
}

enum angular {
	clockwise,
	counterclockwise
}

enum cardinal {
	north,
	south,
	west,
	east
}

enum alignment {
	vertical,
	horizontal
}

enum stairs_directions {
	up, down
}

enum realms {
	thisside,
	otherside
}
	
enum amount {
	lowest,
	very_low,
	low,
	medium,
	high,
	very_high,
	highest
}
	
enum task_types {
	talk_to_someone,
	go_to_room,
	complete_quest,
	find_item,
	go_to_another_floor,
	go_back_one_room
}
	
enum quest_props {
	action,
	npc_dialogue
}
	
enum ev_npc {
	disappear_on_distance,
	transform_into_waiter
}

enum ev_area {
	blinking
}

enum ev_corridor {
	spider
}
	
enum ca {
	entrance_hall,
	players_room
}

enum sg {
	walls,
	doors,
	lamps,
	characters,
	props,
	items,
	overlays,
	wall_props,
	music
}

global.spr_spider_ceiling = sprite_create_transformed(spr_spider, 1, -1, 0)
global.spr_key_0_mirrored = sprite_create_transformed(spr_key_0, -1, -1, 0)

global.task_types_list = [
	task_types.talk_to_someone,
	task_types.go_to_room,
	task_types.complete_quest,
	task_types.find_item,
	task_types.go_to_another_floor,
	task_types.go_back_one_room
]

global.progressive_task_types = [
	task_types.go_to_room,
	task_types.complete_quest,
	task_types.go_back_one_room,
	task_types.go_to_another_floor
]

for (var i = 0; i < 16; i++) {
	event_user(i)	
}