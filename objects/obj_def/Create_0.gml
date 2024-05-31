#macro ev_very_common 50
#macro ev_common 40
//#macro ev_regular 30
//#macro ev_rare 20
//#macro ev_very_rare 10
//#macro ev_anomaly 1

#macro aspect_ratio 16/9
#macro default_block_size 256
#macro wall_passage_width 80
#macro door_order_length 5

#macro game_view_x 16
#macro game_view_y 16
#macro game_view_width 512
#macro game_view_height 288
#macro game_view_center_x (game_view_x + game_view_width*.5)
#macro game_view_center_y (game_view_y + game_view_height*.5)

#macro c_dkblue make_color_rgb(0, 0, 85)
#macro c_blanched_almond make_color_rgb(255, 235, 205)
#macro c_ltgreen make_color_rgb(66, 245, 114)
//#macro c_dkrgray make_color_rgb(25, 25, 25)
//#macro c_fdblack make_color_rgb(9, 9, 9)
//#macro c_dkviolet make_color_rgb(85, 0, 85)
//#macro c_dkindigo make_color_rgb(43, 0, 85)
//#macro c_beige make_color_rgb(245, 245, 220)
//#macro c_violet make_color_rgb(128, 0, 128)

#macro u_mesh_alpha shader_get_uniform(sh_3d_mesh, "alpha")
#macro u_mesh_light_direction shader_get_uniform(sh_3d_mesh, "light_direction")
#macro u_mesh_light_hue shader_get_uniform(sh_3d_mesh, "light_hue")
#macro u_mesh_fog_start shader_get_uniform(sh_3d_mesh, "fog_start")
#macro u_mesh_fog_end shader_get_uniform(sh_3d_mesh, "fog_end")
#macro u_mesh_camera_position shader_get_uniform(sh_3d_mesh, "camera_position")
#macro u_mesh_lighting_enabled shader_get_uniform(sh_3d_mesh, "lighting_enabled")
#macro u_mesh_fog_enabled shader_get_uniform(sh_3d_mesh, "fog_enabled")
#macro u_mesh_fog_color shader_get_uniform(sh_3d_mesh, "fog_color")
#macro u_mesh_color_levels shader_get_uniform(sh_3d_mesh, "color_levels")

#macro u_vhs_tracking_error_alpha shader_get_uniform(sh_vhs_filter, "tracking_error_alpha")
#macro u_vhs_shadow_color shader_get_uniform(sh_vhs_filter, "shadow_color")
#macro u_vhs_saturation shader_get_uniform(sh_vhs_filter, "saturation")
#macro u_vhs_tracking_lines shader_get_sampler_index(sh_vhs_filter, "tracking_lines")
#macro u_vhs_tracking_error_distance shader_get_uniform(sh_vhs_filter, "tracking_error_distance")
#macro u_vhs_tracking_error_variation shader_get_uniform(sh_vhs_filter, "tracking_error_variation")

enum views {
	view_3d,
	view_2d
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
	
enum hint_types {
	talk_to_someone,
	go_to_room,
	fulfill_quest,
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

globalvar	menu_stylesheet,	
			screen_width,
			screen_height,
			window_width,
			window_height,
			seed_groups,
			vertex_format,
			custom_areas,
			custom_areas_door_numbers,
			names,
			cursor_x,
			cursor_y,
			camera_2d,
			camera_3d,
			piano_scores,
			default_dialogues,
			current_realm,
			hint_types_list,
			npc_events,
			area_events,
			corridor_events,
			spr_door_numbers,
			spr_spider_ceiling,
			spr_door_numbers_flipped
			
event_user(0)
event_user(1)
event_user(2)
event_user(4)
event_user(5)
event_user(6)
event_user(7)

spr_spider_ceiling = sprite_create_transformed(spr_spider, 1, -1, 0)

hint_types_list = [
	hint_types.talk_to_someone,
	hint_types.go_to_room,
	hint_types.fulfill_quest,
	hint_types.find_item,
	hint_types.go_to_another_floor,
	hint_types.go_back_one_room
]