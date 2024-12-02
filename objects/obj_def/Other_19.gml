/// @description Sets color palettes

var _game_view_palette = [
	make_color_rgb(7, 8, 9),         // #000000
	make_color_rgb(98, 98, 98),      // #626262
	make_color_rgb(137, 137, 137),   // #898989
	make_color_rgb(173, 173, 173),   // #adadad
	make_color_rgb(255, 255, 255),   // #ffffff
	make_color_rgb(159, 78, 68),     // #9f4e44
	make_color_rgb(203, 126, 117),   // #cb7e75
	make_color_rgb(109, 84, 18),     // #6d5412
	make_color_rgb(161, 104, 60),    // #a1683c
	make_color_rgb(201, 212, 135),   // #c9d487
	make_color_rgb(154, 226, 155),   // #9ae29b
	make_color_rgb(92, 171, 94),     // #5cab5e
	make_color_rgb(106, 191, 198),   // #6abfc6
	make_color_rgb(136, 126, 203),   // #887ecb
	make_color_rgb(80, 69, 155),     // #50459b
	make_color_rgb(160, 87, 163)     // #a057a3
]

var _ui_palette = [
	make_color_rgb(0, 0, 0),         // #000000
	make_color_rgb(98, 98, 98),      // #626262
	make_color_rgb(137, 137, 137),   // #898989
	make_color_rgb(173, 173, 173),   // #adadad
	make_color_rgb(255, 255, 255),   // #ffffff
	make_color_rgb(159, 78, 68),     // #9f4e44
	make_color_rgb(203, 126, 117),   // #cb7e75
	make_color_rgb(109, 84, 18),     // #6d5412
	make_color_rgb(161, 104, 60),    // #a1683c
	make_color_rgb(201, 212, 135),   // #c9d487
	make_color_rgb(154, 226, 155),   // #9ae29b
	make_color_rgb(92, 171, 94),     // #5cab5e
	make_color_rgb(106, 191, 198),   // #6abfc6
	make_color_rgb(136, 126, 203),   // #887ecb
	make_color_rgb(80, 69, 155),     // #50459b
	make_color_rgb(160, 87, 163)     // #a057a3
]
	
global.game_view_palette = []
global.ui_palette = []

array_foreach(_game_view_palette, function(color) {
	var normalized_color = color_get_normalized(color)
		
	array_push(global.game_view_palette, normalized_color[0], normalized_color[1], normalized_color[2])
})

array_foreach(_ui_palette, function(color) {
	var normalized_color = color_get_normalized(color)
		
	array_push(global.ui_palette, normalized_color[0], normalized_color[1], normalized_color[2])
})