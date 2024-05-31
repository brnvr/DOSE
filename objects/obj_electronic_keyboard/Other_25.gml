/// @description def custom shader uniforms

var u_pressed_keys = shader_get_uniform(shader, "pressed_keys")
var u_texture_dimentions = shader_get_uniform(shader, "texture_dimentions")
var u_key = shader_get_uniform(shader, "key")
var u_highlight_key = shader_get_uniform(shader, "highlight_key")
var u_highlight_color = shader_get_uniform(shader, "highlight_color")
var width = sprite_get_width(spr_uv_electronic_keyboard)
var height = sprite_get_height(spr_uv_electronic_keyboard)

var highlight_color

if (wrong_key) {
	highlight_color = [1, 0, 0, 1]
} else if (player_can_play) {
	highlight_color = [1, 0, 1, 1]
} else {
	highlight_color = [0, .5, 1, 1]	
}

var highlight_key = player_can_play || auto_playing || (wrong_key && current_time mod 2 == 0)

shader_set_uniform_f(u_key, key)
shader_set_uniform_i(u_highlight_key, highlight_key)
shader_set_uniform_f_array(u_highlight_color, highlight_color)
shader_set_uniform_f_array(u_texture_dimentions, [width, height])
shader_set_uniform_f_array(u_pressed_keys, keys_pressed)