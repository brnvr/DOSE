/// @description color palettes

var _game_view_palette = [
	 make_color_rgb(242, 174, 153), // #f2ae99
    make_color_rgb(201, 115, 115), // #c97373
    make_color_rgb(166, 85, 95),   // #a6555f
    make_color_rgb(135, 53, 85),   // #873555
    make_color_rgb(97, 24, 81),    // #611851
    make_color_rgb(57, 9, 71),     // #390947
    make_color_rgb(117, 23, 86),   // #751756
    make_color_rgb(163, 40, 88),   // #a32858
    make_color_rgb(204, 66, 94),   // #cc425e
    make_color_rgb(234, 98, 98),   // #ea6262
    make_color_rgb(244, 147, 115), // #f49373
    make_color_rgb(255, 184, 121), // #ffb879
    make_color_rgb(249, 205, 142), // #f9cd8e
    make_color_rgb(252, 239, 141), // #fcef8d
    make_color_rgb(189, 247, 103), // #bdf767
    make_color_rgb(153, 230, 95),  // #99e65f
    make_color_rgb(90, 197, 79),   // #5ac54f
    make_color_rgb(48, 161, 95),   // #30a15f
    make_color_rgb(31, 137, 98),   // #1f8962
    make_color_rgb(24, 104, 91),   // #18685b
    make_color_rgb(14, 56, 80),    // #0e3850
    make_color_rgb(13, 109, 128),  // #0d6d80
    make_color_rgb(27, 156, 149),  // #1b9c95
    make_color_rgb(43, 189, 151),  // #2bbd97
    make_color_rgb(77, 208, 146),  // #4dd092
    make_color_rgb(101, 231, 143), // #65e78f
    make_color_rgb(132, 247, 147), // #84f793
    make_color_rgb(195, 255, 152), // #c3ff98
    make_color_rgb(255, 255, 255), // #ffffff
    make_color_rgb(201, 247, 255), // #c9f7ff
    make_color_rgb(174, 226, 255), // #aee2ff
    make_color_rgb(141, 183, 255), // #8db7ff
    make_color_rgb(109, 128, 250), // #6d80fa
    make_color_rgb(91, 91, 236),   // #5b5bec
    make_color_rgb(102, 70, 222),  // #6646de
    make_color_rgb(97, 40, 175),   // #6128af
    make_color_rgb(78, 24, 124),   // #4e187c
    make_color_rgb(125, 45, 160),  // #7d2da0
    make_color_rgb(131, 77, 196),  // #834dc4
    make_color_rgb(132, 101, 236), // #8465ec
    make_color_rgb(130, 130, 255), // #8282ff
    make_color_rgb(91, 52, 175),   // #5b34af
    make_color_rgb(164, 82, 213),  // #a452d5
    make_color_rgb(205, 91, 227),  // #cd5be3
    make_color_rgb(255, 112, 232), // #ff70e8
    make_color_rgb(255, 195, 242), // #ffc3f2
    make_color_rgb(238, 143, 203), // #ee8fcb
    make_color_rgb(212, 110, 179), // #d46eb3
    make_color_rgb(135, 62, 132),  // #873e84
    make_color_rgb(31, 16, 42),    // #1f102a
    make_color_rgb(74, 48, 82),    // #4a3052
    make_color_rgb(123, 84, 128),  // #7b5480
    make_color_rgb(166, 133, 159), // #a6859f
    make_color_rgb(217, 189, 200), // #d9bdc8
    make_color_rgb(76, 36, 90),    // #4c245a
    make_color_rgb(90, 50, 113),   // #5a3271
    make_color_rgb(91, 65, 128),   // #5b4180
    make_color_rgb(105, 93, 151),  // #695d97
    make_color_rgb(129, 129, 194), // #8181c2
    make_color_rgb(160, 179, 222), // #a0b3de
    make_color_rgb(203, 220, 242), // #cbdcf2
    make_color_rgb(209, 248, 255),  // #d1f8ff
    make_color_rgb(209, 248, 255),  // #d1f8ff
    make_color_rgb(209, 248, 255)  // #d1f8ff
]

var _ui_palette = [
	make_color_rgb(0, 0, 0)		
]

array_copy(_ui_palette, 1, _game_view_palette, 1, array_length(_game_view_palette)-1)

	
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