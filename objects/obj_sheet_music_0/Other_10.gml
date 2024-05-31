/// @description position over keyboard

var dcos_rot = dcos(keyboard.zrotation)
var dsin_rot = dsin(keyboard.zrotation)

keyboard.sheet_music = id
vbuff_list = [vbuff_billboard]
billboard = false
x = keyboard.x + 13 * dcos_rot
y = keyboard.y + 13 * dsin_rot
z = keyboard.z - 76
zrotation = keyboard.zrotation

keyboard.on_interact()