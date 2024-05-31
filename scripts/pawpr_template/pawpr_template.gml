function pawpr_template(custom_types={}) {
	var custom_type_names, n_custom_types;
	
	static template = {
		"string": {
			draw: function(element) {
				pawpr_element_draw_default(element, function(element, x, y) {
					var scale, line_separation, line_width, color, alpha, shadow_color, shadow_alpha, shadow_xdist, shadow_ydist,
						color_previous, alpha_previous, halign_previous, valign_previous, font, font_previous, expansion, draw_scale;
					
					alpha = pawpr_element_get_style(element, pawpr.alpha, 1);
					if (alpha <= 0) return;
					scale = pawpr_element_get_style(element, pawpr.scale, 1);
					color = pawpr_element_get_style(element, pawpr.color, c_white);	
					font = pawpr_element_get_style(element, pawpr.font, -1);
					line_separation = pawpr_element_get_style(element, pawpr.line_separation, -1);
					line_width = pawpr_element_get_style(element, pawpr.line_width, -1);
					shadow_color = pawpr_element_get_style(element, pawpr.shadow_color, c_black);
					shadow_alpha = pawpr_element_get_style(element, pawpr.shadow_alpha, 0);
					shadow_xdist = pawpr_element_get_style(element, pawpr.shadow_xdistance, 1);
					shadow_ydist = pawpr_element_get_style(element, pawpr.shadow_ydistance, 1);
					expansion = pawpr_element_get_style(element, pawpr.expansion, 1);
				
					color_previous = draw_get_color();
					alpha_previous = draw_get_alpha();
					halign_previous = draw_get_halign();
					valign_previous = draw_get_valign();
					font_previous = draw_get_font();
					
					draw_set_color(color);
					draw_set_alpha(alpha);
					if (font != -1) draw_set_font(font);
					draw_set_halign(fa_left);
					draw_set_valign(fa_top);
					
					draw_scale = scale*expansion;
					
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
					var scale, line_separation, line_width, font, font_previous, width, expansion;
					
					font_previous = draw_get_font();
					
					scale = pawpr_element_get_style(element, pawpr.scale, 1);
					line_separation = pawpr_element_get_style(element, pawpr.line_separation, -1);
					line_width = pawpr_element_get_style(element, pawpr.line_width, -1);
					font = pawpr_element_get_style(element, pawpr.font, -1);
					expansion = pawpr_element_get_style(element, pawpr.expansion, 1);
					
					if (font != -1) draw_set_font(font);
					
					width = string_width_ext(element[pawpr_attr.content], line_separation, line_width)*scale;

					draw_set_font(font_previous);
					return width;
				});
			},
			
			get_height: function(element) {
				return pawpr_element_get_height_default(element, function(element) {
					var scale, line_separation, line_width, font, font_previous, height, expansion;
					
					font_previous = draw_get_font();
					
					scale = pawpr_element_get_style(element, pawpr.scale, 1);
					line_separation = pawpr_element_get_style(element, pawpr.line_separation, -1);
					line_width = pawpr_element_get_style(element, pawpr.line_width, -1);
					font = pawpr_element_get_style(element, pawpr.font, -1);
					expansion = pawpr_element_get_style(element, pawpr.expansion, 1);
					
					if (font != -1) draw_set_font(font);
					
					height = string_height_ext(element[pawpr_attr.content], line_separation, line_width)*scale;
					draw_set_font(font_previous);
					return height;
				});
			},
			
			get_xoffset: pawpr_element_get_xoffset_default,	
			get_yoffset: pawpr_element_get_yoffset_default
		},
	
		"sprite": {
			on_create: function(element) {
				var style;
				
				style = element[pawpr_attr.style];
				
				if (is_undefined(style[pawpr.image_index])) {
					style[pawpr.image_index] = 0;
				}
				
				if (is_undefined(style[pawpr.image_speed])) {
					style[pawpr.image_speed] = 1;
				}
			},
			
			on_update: function(element) {
				var n_images, style;
				
				style = element[pawpr_attr.style];
				n_images = sprite_get_number(element[pawpr_attr.content]);
				style[pawpr.image_index] = (style[pawpr.image_index] + style[pawpr.image_speed]) mod n_images;	
			},
			
			draw: function(element) {
				pawpr_element_draw_default(element, function(element, x, y) {
					var scale, color, alpha, expansion, draw_scale, xorigin, yorigin;
					
					scale = pawpr_element_get_style(element, pawpr.scale, 1);
					color = pawpr_element_get_style(element, pawpr.color, c_white);
					alpha = pawpr_element_get_style(element, pawpr.alpha, 1);
					expansion = pawpr_element_get_style(element, pawpr.expansion, 1);			
					draw_scale = scale*expansion;
					xorigin = sprite_get_xoffset(element[pawpr_attr.content]);
					yorigin = sprite_get_yoffset(element[pawpr_attr.content]);
					
					draw_sprite_ext(element[pawpr_attr.content], element[pawpr_attr.style][pawpr.image_index], x+xorigin*scale, y+yorigin*scale, draw_scale, draw_scale, 0, color, alpha);
				});
			},
			
			get_width: function(element) {
				return pawpr_element_get_width_default(element, function(element) {
					var scale;
					
					scale = pawpr_element_get_style(element, pawpr.scale, 1);
					
					return sprite_get_width(element[pawpr_attr.content])*scale;
				});
			},
			
			get_height: function(element) {
				return pawpr_element_get_height_default(element, function(element) {
					var scale;
					
					scale = pawpr_element_get_style(element, pawpr.scale, 1);
					
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
					var dir, content_length, width;
					
					content_length = array_length(element[pawpr_attr.content]);
					width = 0;
					dir = pawpr_element_get_style(element, pawpr.direction, pawpr_direction.row);
					
					for (var i = 0; i < content_length; i++) {
						var child, child_margin, child_margin_left, child_margin_right, width_partial, child_xoffset;
						
						child_xoffset = pawpr_element_get_style(element, pawpr.yoffset, 0);
						child = element[pawpr_attr.content][i];
						child_margin = pawpr_element_get_style(child, pawpr.margin, 0);
						child_margin_left = pawpr_element_get_style(child, pawpr.margin_left, child_margin);
						child_margin_right = pawpr_element_get_style(child, pawpr.margin_right, child_margin);
						width_partial = child_margin_left + child[pawpr_attr.width] + child_margin_right + child_xoffset;
						
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
					var dir, content_length, height;
					
					content_length = array_length(element[pawpr_attr.content]);
					height = 0;
					dir = pawpr_element_get_style(element, pawpr.direction, pawpr_direction.row);
					
					for (var i = 0; i < content_length; i++) {
						var child, child_margin, child_margin_top, child_margin_bottom, child_yoffset, height_partial;
						
						child = element[pawpr_attr.content][i];
						child_yoffset = pawpr_element_get_style(element, pawpr.yoffset, 0);
						child_margin = pawpr_element_get_style(child, pawpr.margin, 0);
						child_margin_top = pawpr_element_get_style(child, pawpr.margin_top, child_margin);
						child_margin_bottom = pawpr_element_get_style(child, pawpr.margin_bottom, child_margin);
						height_partial = child_margin_top + child[pawpr_attr.height] + child_margin_bottom + child_yoffset;
						
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
	
	custom_type_names = variable_struct_get_names(custom_types);
	n_custom_types = array_length(custom_type_names);
	
	for (var i = 0; i < n_custom_types; i++) {
		var name;
		
		name = custom_type_names[i];
		
		variable_struct_set(template, name, variable_struct_get(custom_types, name));
	}
	
	return template;
}