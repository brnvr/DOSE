/// @descriptions stylesheets

global.menu_stylesheet = pawpr_stylesheet({
	"menu": {
		"direction": pawpr_direction.column,
		"font": font_dark_dream
	},
	
	"option_container": {
		"background_color": c_terra_cotta,
		"background_alpha": 0,
		"min_width": 200,
		"align": pawpr_align.at_center,
		"direction": pawpr_direction.column,
		"shadow_alpha": 1,
		
		"hover": {
			"background_alpha": .3
		}
	},
	
	"option_container_disabled": {
		"align": pawpr_align.at_center,
		"direction": pawpr_direction.column,
		"min_width": 200,
		"color": c_gray,
		"shadow_alpha": 1
	}
});

global.npc_options_stylesheet = pawpr_stylesheet({
	"menu": {
		"direction": pawpr_direction.column,
		"font": font_dark_dream
	},
	
	"option_container": {
		"background_color": c_terra_cotta,
		"background_alpha": .3,
		"min_width": 200,
		"margin": 3,
		"align": pawpr_align.at_center,
		"direction": pawpr_direction.column,
		"shadow_alpha": 1,
		
		"hover": {
			"background_alpha": .6
		}
	},
	
	"option_container_disabled": {
		"align": pawpr_align.at_center,
		"direction": pawpr_direction.column,
		"min_width": 200,
		"color": c_gray,
	}
});