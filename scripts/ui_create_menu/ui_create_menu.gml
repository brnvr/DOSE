function ui_create_menu(xpos, ypos, menu_options, stylesheet=menu_stylesheet, hor_align=pawpr_align.at_center, vert_align=pawpr_align.at_center) {
	var ui, menu_content, n_options;
	
	ui = pawpr_ui(xpos, ypos, stylesheet, hor_align, vert_align);

	menu_content = [];
	
	n_options = array_length(menu_options);

	for (var i = 0; i < n_options; i++) {
		var class_name = "";
		
		var option = menu_options[i];
		
		if (array_length(option) > 2 && !option[2]) {
			class_name = "option_container_disabled";
		} else {
			class_name = "option_container";	
		}
		
		array_push(menu_content, {
			class: class_name,
			
			content: [
				{
					class: "option",
					type: "string",
					content: option[0],
				}
			],
			
			on_mouse_over: function(args) {
				if (mouse_check_button_pressed(mb_left)) {
					args[0]();
				}
			},
			
			args: array_length(option) > 1 ? [option[1]] : [function() {}]
		});
	};

	pawpr_add_content(ui, {
		class: "menu",
		content: menu_content
	});

	pawpr_build(ui);
	
	return ui;
}