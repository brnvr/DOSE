if (view_current == views.view_2d) {
	if (annotations_offset <= 40) {
		draw_sprite(spr_annotations_paper, 0, 0, annotations_offset+25)
		draw_set_color(c_black)
		draw_set_halign(fa_center)
		draw_set_valign(fa_top)
		shader_reset()
	
		var descriptions = obj_player.get_hints_descriptions()
	
		array_foreach(descriptions, function(description, index) {
			draw_text_transformed(0, annotations_offset+index*18-40, "- " + description, .7, .7, 0)
		})
	}	
}