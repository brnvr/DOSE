arrows_alpha[0] = .3
arrows_alpha[1] = .3

if (yoffset > 0) {
	yoffset = smooth_interpolation(yoffset, .13);
}

var hover_left_arrow = point_in_rectangle(
		window_mouse_get_x(),
		window_mouse_get_y(),
		game_view_center_x - arrows_xdist - arrows_bbox[2],
		game_view_center_y + arrows_bbox[1],
		game_view_center_x - arrows_xdist - arrows_bbox[0],
		game_view_center_y + arrows_bbox[3])
		
var hover_right_arrow = point_in_rectangle(
		window_mouse_get_x(),
		window_mouse_get_y(),
		game_view_center_x + arrows_xdist + arrows_bbox[0],
		game_view_center_y + arrows_bbox[1],
		game_view_center_x + arrows_xdist + arrows_bbox[2],
		game_view_center_y + arrows_bbox[3])

if (hover_left_arrow) {
	arrows_alpha[0] = .6
	
	mouse_click(mb_left, function() {
		if (photo_index == 0) {
			photo_index = array_length(photographs) - 1
			
			return
		}
		
		photo_index--
	})
}

if (hover_right_arrow) {
	arrows_alpha[1] = .6
	
	mouse_click(mb_left, function() {
		if (photo_index == array_length(photographs) - 1) {
			photo_index = 0
			
			return
		}
		
		photo_index++
	})
}