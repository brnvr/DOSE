xfrom = 0
yfrom = 0
zfrom = 0
xto = 0
yto = 0
zto = 0
xup = 0
yup = 0
zup = 0

proj_mat = matrix_build_projection_perspective_fov(fov_y, aspect, znear, zfar)
view_mat = []

event_inherited()