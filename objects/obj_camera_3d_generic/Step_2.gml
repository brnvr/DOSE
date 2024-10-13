if (limit_yaw) {
	yaw = clamp(yaw, yaw_min, yaw_max)
}

if (limit_pitch) {
	pitch = clamp(pitch, pitch_min, pitch_max)
}

if (limit_roll) {
	roll = clamp(roll, roll_min, roll_max)
}

var yawcos = dcos(yaw)
var yawsin = dsin(yaw)
var pitchsin = dsin(pitch)
var pitchcos = dcos(pitch)
var rollsin = dsin(roll)
var rollcos = dcos(roll)

xfrom = x+xoffset
yfrom = y+yoffset
zfrom = z+zoffset
xto = xfrom+yawcos*pitchcos
yto = yfrom-yawsin*pitchcos
zto = zfrom-pitchsin
xup = -rollsin*yawsin*pitchcos
yup = -rollsin*yawcos*pitchcos
zup = rollcos

view_mat = matrix_build_lookat(xfrom, yfrom, zfrom, xto, yto, zto, xup, yup, zup)

event_inherited()

