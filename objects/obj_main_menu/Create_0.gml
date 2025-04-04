game_starting = false
alpha = 1
player_camera = obj_player.camera
camera_pitch_start = 9
camera_yaw_start = 270

yaw_wave = instance_create_depth(0, 0, 0, obj_wave, {
	speed: .1,
	amplitude: 18
})

pitch_wave = instance_create_depth(0, 0, 0, obj_wave, {
	speed: .13,
	amplitude: 5
})

start_game = function() {
	game_starting = true;
	game_set_music_track(noone)
	obj_cursor.sprite_index = noone
}

obj_player.can_move = false
obj_player.can_interact = false
obj_player.can_look = false

cursor_set_sprite(spr_cursor_arrow)
game_set_music_track(snd_umc_unrealed, obj_settings.music_volume)
instance_deactivate_object(obj_eyes)

menu_options = [
	["Continue", function() {}, false],
	["Start new game", start_game],
	["Options"],
	["Credits"],
	["Exit to Windows", game_end]
]

ui = ui_create_menu(0, 20, menu_options, global.menu_stylesheet, pawpr_align.at_center, pawpr_align.at_start)

instance_create_layer(0, 0, "Abstract", obj_fade_in, {
	spd: 0.005,
	gui: true
})