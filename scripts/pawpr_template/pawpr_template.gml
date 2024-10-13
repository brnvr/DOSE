function pawpr_template(custom_types={}) {
	static template = {
		"string": {
			draw: function(element) {
				pawpr_element_draw_default(element, function(element, x, y) {
					var alpha = pawpr_element_get_style(element, pawpr.alpha, 1);
					if (alpha <= 0) return;
					var scale = pawpr_element_get_style(element, pawpr.scale, 1);
					var color = pawpr_element_get_style(element, pawpr.color, c_white);	
					var font = pawpr_element_get_style(element, pawpr.font, -1);
					var line_separation = pawpr_element_get_style(element, pawpr.line_separation, -1);
					var line_width = pawpr_element_get_style(element, pawpr.line_width, -1);
					var shadow_color = pawpr_element_get_style(element, pawpr.shadow_color, c_black);
					var shadow_alpha = pawpr_element_get_style(element, pawpr.shadow_alpha, 0);
					var shadow_xdist = pawpr_element_get_style(element, pawpr.shadow_xdistance, 1);
					var shadow_ydist = pawpr_element_get_style(element, pawpr.shadow_ydistance, 1);
					var expansion = pawpr_element_get_style(element, pawpr.expansion, 1);
				
					var color_previous = draw_get_color();
					var alpha_previous = draw_get_alpha();
					var halign_previous = draw_get_halign();
					var valign_previous = draw_get_valign();
					var font_previous = draw_get_font();
					
					draw_set_color(color);
					draw_set_alpha(alpha);
					if (font != -1) draw_set_font(font);
					draw_set_halign(fa_left);
					draw_set_valign(fa_top);
					
					var draw_scale = scale*expansion;
					
					pawpr_draw_text_ext_transformed_shadow(
						x, y, element[pawpr_attr.content], line_separation, line_width, draw_scale, draw_scale, 0, shadow_color, shadow_alpha, shadow_xdist, shadow_ydist);
					
					draw_set_color(color_previous);
					draw_set_alpha(alpha_previous);
					draw_set_halign(halign_previous)
					draw_set_valign(valign_previous);
					draw_set_font(font_previous);
				});	
			},
			
			get_width: function(element) {
				return pawpr_element_get_width_default(element, function(element) {
					var font_previous = draw_get_font();
					
					var scale = pawpr_element_get_style(element, pawpr.scale, 1);
					var line_separation = pawpr_element_get_style(element, pawpr.line_separation, -1);
					var line_width = pawpr_element_get_style(element, pawpr.line_width, -1);
					var font = pawpr_element_get_style(element, pawpr.font, -1);
					var expansion = pawpr_element_get_style(element, pawpr.expansion, 1);
					
					if (font != -1) draw_set_font(font);
					
					var width = string_width_ext(element[pawpr_attr.content], line_separation, line_width)*scale;

					draw_set_font(font_previous);
					return width;
				});
			},
			
			get_height: function(element) {
				return pawpr_element_get_height_default(element, function(element) {
					var font_previous = draw_get_font();
					
					var scale = pawpr_element_get_style(element, pawpr.scale, 1);
					var line_separation = pawpr_element_get_style(element, pawpr.line_separation, -1);
					var line_width = pawpr_element_get_style(element, pawpr.line_width, -1);
					var font = pawpr_element_get_style(element, pawpr.font, -1);
					var expansion = pawpr_element_get_style(element, pawpr.expansion, 1);
					
					if (font != -1) draw_set_font(font);
					
					var height = string_height_ext(element[pawpr_attr.content], line_separation, line_width)*scale;
					draw_set_font(font_previous);
					return height;
				});
			},
			
			get_xoffset: pawpr_element_get_xoffset_default,	
			get_yoffset: pawpr_element_get_yoffset_default
		},
	
		"sprite": {
			on_create: function(element) {
				var style = element[pawpr_attr.style];
				
				if (is_undefined(style[pawpr.image_index])) {
					style[pawpr.image_index] = 0;
				}
				
				if (is_undefined(style[pawpr.image_speed])) {
					style[pawpr.image_speed] = 1;
				}
			},
			
			on_update: function(element) {
				var style = element[pawpr_attr.style];
				var n_images = sprite_get_number(element[pawpr_attr.content]);
				style[pawpr.image_index] = (style[pawpr.image_index] + style[pawpr.image_speed]) mod n_images;	
			},
			
			draw: function(element) {
				pawpr_element_draw_default(element, function(element, x, y) {
					var scale = pawpr_element_get_style(element, pawpr.scale, 1);
					var color = pawpr_element_get_style(element, pawpr.color, c_white);
					var alpha = pawpr_element_get_style(element, pawpr.alpha, 1);
					var expansion = pawpr_element_get_style(element, pawpr.expansion, 1);			
					var draw_scale = scale*expansion;
					var xorigin = sprite_get_xoffset(element[pawpr_attr.content]);
					var yorigin = sprite_get_yoffset(element[pawpr_attr.content]);
					
					draw_sprite_ext(element[pawpr_attr.content], element[pawpr_attr.style][pawpr.image_index], x+xorigin*scale, y+yorigin*scale, draw_scale, draw_scale, 0, color, alpha);
				});
			},
			
			get_width: function(element) {
				return pawpr_element_get_width_default(element, function(element) {
					var scale = pawpr_element_get_style(element, pawpr.scale, 1);
					
					return sprite_get_width(element[pawpr_attr.content])*scale;
				});
			},
			
			get_height: function(element) {
				return pawpr_element_get_height_default(element, function(element) {
					var scale = pawpr_element_get_style(element, pawpr.scale, 1);
					
					return sprite_get_height(element[pawpr_attr.content])*scale;
				});
			},
			
			get_xoffset: pawpr_element_get_xoffset_default,	
			get_yoffset: pawpr_element_get_yoffset_default
		},
		
		"container": {
			draw: function(element) {
				pawpr_element_draw_default(element, function() {});
			},
			
			get_width: function(element) {
				return pawpr_element_get_width_default(element, function(element) {
					var content_length = array_length(element[pawpr_attr.content]);
					var width = 0;
					var dir = pawpr_element_get_style(element, pawpr.direction, pawpr_direction.row);
					
					for (var i = 0; i < content_length; i++) {
						var child_xoffset = pawpr_element_get_style(element, pawpr.yoffset, 0);
						var child = element[pawpr_attr.content][i];
						var child_margin = pawpr_element_get_style(child, pawpr.margin, 0);
						var child_margin_left = pawpr_element_get_style(child, pawpr.margin_left, child_margin);
						var child_margin_right = pawpr_element_get_style(child, pawpr.margin_right, child_margin);
						var width_partial = child_margin_left + child[pawpr_attr.width] + child_margin_right + child_xoffset;
						
						switch (dir) {
							case pawpr_direction.row:
								width += width_partial;
								break;
								
							case pawpr_direction.column:
								width = max(width, width_partial);
								break;
								
							default:
								throw "Invalid element direction";
						}
						
					}

					return width;
				});
			},
			
			get_height: function(element) {
				return pawpr_element_get_height_default(element, function(element) {
					var content_length = array_length(element[pawpr_attr.content]);
					var height = 0;
					var dir = pawpr_element_get_style(element, pawpr.direction, pawpr_direction.row);
					
					for (var i = 0; i < content_length; i++) {
						var child = element[pawpr_attr.content][i];
						var child_yoffset = pawpr_element_get_style(element, pawpr.yoffset, 0);
						var child_margin = pawpr_element_get_style(child, pawpr.margin, 0);
						var child_margin_top = pawpr_element_get_style(child, pawpr.margin_top, child_margin);
						var child_margin_bottom = pawpr_element_get_style(child, pawpr.margin_bottom, child_margin);
						var height_partial = child_margin_top + child[pawpr_attr.height] + child_margin_bottom + child_yoffset;
						
						switch (dir) {
							case pawpr_direction.column:
								height += height_partial;
								break;
								
							case pawpr_direction.row:
								height = max(height, height_partial);
								break;
								
							default:
								throw "Invalid element direction";
						}
					}
					
					return height;
				});
			},
			
			get_xoffset: pawpr_element_get_xoffset_default,
			get_yoffset: pawpr_element_get_yoffset_default
		}
	}
	
	var custom_type_names = variable_struct_get_names(custom_types);
	var n_custom_types = array_length(custom_type_names);
	
	for (var i = 0; i < n_custom_types; i++) {
		var name = custom_type_names[i];
		
		variable_struct_set(template, name, variable_struct_get(custom_types, name));
	}
	
	return template;
}