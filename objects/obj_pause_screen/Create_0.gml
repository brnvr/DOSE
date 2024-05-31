resume_game = function() {
	game_unpause();
}

load_game = function() {}

options = function() {}

exit_to_main_menu = function() {}

exit_to_windows = function() {
	game_end();
}

style = {
	menu: {
		background_color: c_black,
		background_alpha: 1,
		direction: ui_direction.column,
		halign: ui_align.screen_center,
		valign: ui_align.screen_center,
		justify: "center",
	},
	
	menu_title: {
		color: c_ltgray,
		scale: 2,
		margin_bottom: 12,
		padding: 5,
	},
	
	menu_body: {
		direction: ui_direction.column
	},
	
	menu_item: {
		background_alpha: 0,
		background_color: c_dkblue,
		color: c_white,
		scale: 1,
		padding: 5,
		padding_left: 20,
		padding_right: 20,
		fill_space_around: true,
		
		hover: {
			background_alpha: 1	
		}
	}
}

menu_items = [
	{class_name: "menu_item", content_type: "STRING", content: "Resume", onclick: resume_game},
	{class_name: "menu_item", content_type: "STRING", content: "Load game", onclick: load_game},
	{class_name: "menu_item", content_type: "STRING", content: "Options", onclick: options},
	{class_name: "menu_item", content_type: "STRING", content: "Exit to main menu", onclick: exit_to_main_menu},
	{class_name: "menu_item", content_type: "STRING", content: "Exit to Windows", onclick: exit_to_windows},
];

menu =	{class_name: "menu", content: [
	{class_name: "menu_title", content_type: "STRING", content: "PAUSED"},
	{class_name: "menu_body", content: menu_items}
]};	

ui_build(menu, style);