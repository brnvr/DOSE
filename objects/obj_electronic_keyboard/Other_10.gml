/// @description player get out

in_use = false
obj_player.focus = noone
obj_player.can_interact = false
player_can_play = false
is_player_moving_away = true

if (sheet_music != noone) {
	obj_player.inventory_add_item(sheet_music)
	
	instance_destroy(sheet_music)
	sheet_music = noone
}

var dcos_rot = dcos(zrotation)
var dsin_rot = dsin(zrotation)

obj_player.move_to(obj_player.x - dcos_rot * 24, obj_player.y - dsin_rot * 24, obj_player.WALK_SPEED/2, function() {
	obj_player.can_move = true	
	is_player_moving_away = false
	obj_cursor.visible = true
	cursor_set_sprite(interactable_get_hover_sprite(obj_player.actor_hover))
})


time_source_stop(ts_init)