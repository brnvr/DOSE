/// @description color palettes
var _game_view_palette = [
	make_color_rgb(5, 9, 20),      // #050914
    make_color_rgb(17, 5, 36),     // #110524
    make_color_rgb(59, 6, 58),     // #3b063a
    make_color_rgb(105, 23, 73),   // #691749
    make_color_rgb(156, 50, 71),   // #9c3247
    make_color_rgb(212, 100, 83),  // #d46453
    make_color_rgb(245, 161, 93),  // #f5a15d
    make_color_rgb(255, 207, 142), // #ffcf8e
    make_color_rgb(255, 122, 125), // #ff7a7d
    make_color_rgb(255, 65, 125),  // #ff417d
    make_color_rgb(214, 26, 136),  // #d61a88
    make_color_rgb(148, 0, 122),   // #94007a
    make_color_rgb(66, 0, 78),     // #42004e
    make_color_rgb(34, 0, 41),     // #220029
    make_color_rgb(16, 7, 38),     // #100726
    make_color_rgb(37, 8, 44),     // #25082c
    make_color_rgb(61, 17, 50),    // #3d1132
    make_color_rgb(115, 38, 61),   // #73263d
    make_color_rgb(189, 64, 53),   // #bd4035
    make_color_rgb(237, 123, 57),  // #ed7b39
    make_color_rgb(255, 184, 74),  // #ffb84a
    make_color_rgb(255, 245, 64),  // #fff540
    make_color_rgb(198, 216, 49),  // #c6d831
    make_color_rgb(119, 176, 42),  // #77b02a
    make_color_rgb(66, 144, 88),   // #429058
    make_color_rgb(44, 100, 94),   // #2c645e
    make_color_rgb(21, 60, 74),    // #153c4a
    make_color_rgb(5, 33, 55),     // #052137
    make_color_rgb(14, 4, 33),     // #0e0421
    make_color_rgb(12, 11, 66),    // #0c0b42
    make_color_rgb(3, 39, 105),    // #032769
    make_color_rgb(20, 68, 145),   // #144491
    make_color_rgb(72, 139, 212),  // #488bd4
    make_color_rgb(120, 215, 255), // #78d7ff
    make_color_rgb(176, 255, 241), // #b0fff1
    make_color_rgb(250, 255, 255), // #faffff
    make_color_rgb(199, 212, 225), // #c7d4e1
    make_color_rgb(146, 143, 184), // #928fb8
    make_color_rgb(91, 83, 125),   // #5b537d
    make_color_rgb(57, 41, 70),    // #392946
    make_color_rgb(36, 20, 44),    // #24142c
    make_color_rgb(14, 15, 44),    // #0e0f2c
    make_color_rgb(19, 34, 67),    // #132243
    make_color_rgb(26, 70, 107),   // #1a466b
    make_color_rgb(16, 144, 142),  // #10908e
    make_color_rgb(40, 192, 116),  // #28c074
    make_color_rgb(61, 255, 110),  // #3dff6e
    make_color_rgb(248, 255, 184), // #f8ffb8
    make_color_rgb(240, 194, 151), // #f0c297
    make_color_rgb(207, 150, 140), // #cf968c
    make_color_rgb(143, 87, 101),  // #8f5765
    make_color_rgb(82, 41, 75),    // #52294b
    make_color_rgb(15, 2, 46),     // #0f022e
    make_color_rgb(53, 0, 59),     // #35003b
    make_color_rgb(100, 0, 76),    // #64004c
    make_color_rgb(155, 14, 62),   // #9b0e3e
    make_color_rgb(212, 30, 60),   // #d41e3c
    make_color_rgb(237, 76, 64),   // #ed4c40
    make_color_rgb(255, 151, 87),  // #ff9757
    make_color_rgb(212, 102, 47),  // #d4662f
    make_color_rgb(156, 52, 26),   // #9c341a
    make_color_rgb(105, 27, 34),   // #691b22
    make_color_rgb(69, 12, 40),    // #450c28
    make_color_rgb(45, 0, 46)      // #2d002e
]
var _game_view_palette = [
	make_color_rgb(5, 9, 20), // #050914
    make_color_rgb(17, 5, 36), // #110524
    make_color_rgb(59, 6, 58), // #3b063a
    make_color_rgb(105, 23, 73), // #691749
    make_color_rgb(156, 50, 71), // #9c3247
    make_color_rgb(212, 100, 83), // #d46453
    make_color_rgb(245, 161, 93), // #f5a15d
    make_color_rgb(255, 207, 142), // #ffcf8e
    make_color_rgb(255, 122, 125), // #ff7a7d
    make_color_rgb(255, 65, 125), // #ff417d
    make_color_rgb(214, 26, 136), // #d61a88
    make_color_rgb(148, 0, 122), // #94007a
    make_color_rgb(66, 0, 78), // #42004e
    make_color_rgb(34, 0, 41), // #220029
    make_color_rgb(16, 7, 38), // #100726
    make_color_rgb(37, 8, 44), // #25082c
    make_color_rgb(61, 17, 50), // #3d1132
    make_color_rgb(115, 38, 61), // #73263d
    make_color_rgb(189, 64, 53), // #bd4035
    make_color_rgb(237, 123, 57), // #ed7b39
    make_color_rgb(255, 184, 74), // #ffb84a
    make_color_rgb(255, 245, 64), // #fff540
    make_color_rgb(198, 216, 49), // #c6d831
    make_color_rgb(119, 176, 42), // #77b02a
    make_color_rgb(66, 144, 88), // #429058
    make_color_rgb(44, 100, 94), // #2c645e
    make_color_rgb(21, 60, 74), // #153c4a
    make_color_rgb(5, 33, 55), // #052137
    make_color_rgb(14, 4, 33), // #0e0421
    make_color_rgb(12, 11, 66), // #0c0b42
    make_color_rgb(3, 39, 105), // #032769
    make_color_rgb(20, 68, 145), // #144491
    make_color_rgb(72, 139, 212), // #488bd4
    make_color_rgb(120, 215, 255), // #78d7ff
    make_color_rgb(176, 255, 241), // #b0fff1
    make_color_rgb(250, 255, 255), // #faffff
    make_color_rgb(199, 212, 225), // #c7d4e1
    make_color_rgb(146, 143, 184), // #928fb8
    make_color_rgb(91, 83, 125), // #5b537d
    make_color_rgb(57, 41, 70), // #392946
    make_color_rgb(36, 20, 44), // #24142c
    make_color_rgb(14, 15, 44), // #0e0f2c
    make_color_rgb(19, 34, 67), // #132243
    make_color_rgb(26, 70, 107), // #1a466b
    make_color_rgb(16, 144, 142), // #10908e
    make_color_rgb(40, 192, 116), // #28c074
    make_color_rgb(61, 255, 110), // #3dff6e
    make_color_rgb(248, 255, 184), // #f8ffb8
    make_color_rgb(240, 194, 151), // #f0c297
    make_color_rgb(207, 150, 140), // #cf968c
    make_color_rgb(143, 87, 101), // #8f5765
    make_color_rgb(82, 41, 75), // #52294b
    make_color_rgb(15, 2, 46), // #0f022e
    make_color_rgb(53, 0, 59), // #35003b
    make_color_rgb(100, 0, 76), // #64004c
    make_color_rgb(155, 14, 62), // #9b0e3e
    make_color_rgb(212, 30, 60), // #d41e3c
    make_color_rgb(237, 76, 64), // #ed4c40
    make_color_rgb(255, 151, 87), // #ff9757
    make_color_rgb(212, 102, 47), // #d4662f
    make_color_rgb(156, 52, 26), // #9c341a
    make_color_rgb(105, 27, 34), // #691b22
    make_color_rgb(69, 12, 40), // #450c28
    make_color_rgb(45, 0, 46) // #2d002e
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