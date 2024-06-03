var yawcos, yawsin, pitchcos, pitchsin, rollcos, rollsin

if (limit_yaw) {
	yaw = clamp(yaw, yaw_min, yaw_max)
}

if (limit_pitch) {
	pitch = clamp(pitch, pitch_min, pitch_max)
}

if (limit_roll) {
	roll = clamp(roll, roll_min, roll_max)
}

yawcos = dcos(yaw)
yawsin = dsin(yaw)
pitchsin = dsin(pitch)
pitchcos = dcos(pitch)
rollsin = dsin(roll)
rollcos = dcos(roll)

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

