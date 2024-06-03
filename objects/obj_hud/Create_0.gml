#macro ITEM_PICKED_SPEED 13
#macro INVENTORY_CENTER_X screen_width-44
#macro INVENTORY_CENTER_Y 112
#macro INVENTORY_ITEM_SIZE 64
#macro ITEM_PICKED_INITIAL_SCALE 1

display_overlay_0 = false;
display_overlay_1 = false;
display_inventory = true;
display_annotations = false;
annotations_offset = 0;
speech = "";
is_speaking = false;
item_picked = noone;
inventory_temp = -1;
inventory_item_selected_scale = 1;
eyes = instance_create_layer(593, 260, "GUI", obj_eyes);
hud_panel = sprite_create_from_assembly(spr_hud_panel, 2);
inventory_button_up_selected = false;
inventory_button_down_selected = false;
ts_unselect_inventory_button = time_source_create(time_source_global, 2, time_source_units_frames, function() {
	inventory_button_up_selected = false;
	inventory_button_down_selected = false;
});
ts_hide_speech = time_source_create(time_source_global, 0, time_source_units_frames, function() { });

show_speech = function(s, hide_timeout=false, timeout_period=-1) {
	if (is_array(s)) {
		speech = array_choose(s);
	} else if (is_string(s)) {
		speech = s;
	} else {
		show_error("'s' should be a string or an array", true);	
	}
	
	if (hide_timeout) {
		var period;
		
		if (timeout_period >= 0) {
			period = timeout_period;
		} else {
			period = floor(40 + 3.5*string_length(s));
		}
	
		time_source_reconfigure(ts_hide_speech, period, time_source_units_frames, function() {
			speech = "";	
		});
	
		time_source_start(ts_hide_speech);
	}
}

draw_inventory_item = function(xpos, ypos, item_index, draw_number=true, scale=1, saturation=1, pixel_size = 0) {
	var sprite = inventory_temp[item_index].sprite;
	
	shader_set_ui(saturation, 5, pixel_size, sprite);
	draw_sprite_ext(sprite, 0,
	xpos + sprite_get_draw_center_x(sprite, scale),
	ypos + sprite_get_draw_center_y(sprite, scale), scale, scale, 0, c_white, 1);	
	shader_reset();
	if (draw_number) {
		var number;
		
		number = inventory_temp[item_index].number;
		
		if (number > 1) {
			draw_text_border_ext_transformed(xpos+10, ypos+17, $"x{number}", 0, -1, 1, 1, c_black);
		}
	}
}

inventory_button_up_set_selected = function() {
	inventory_button_up_selected = true;
	time_source_start(ts_unselect_inventory_button);
}

inventory_button_down_set_selected = function() {
	inventory_button_down_selected = true;	
	time_source_start(ts_unselect_inventory_button);
}

scale_inventory_item_selected = function() {
	inventory_item_selected_scale = 1.25;
}

set_item_picked = function(index, sprite, name) {
	item_picked = {
		"sprite": sprite,
		"x": cursor_x + sprite_get_draw_center_x(sprite, ITEM_PICKED_INITIAL_SCALE),
		"y": cursor_y + sprite_get_draw_center_y(sprite, ITEM_PICKED_INITIAL_SCALE),
		"scale": ITEM_PICKED_INITIAL_SCALE,
		"name": name,
		"index": index
	}
}

add_message = function(msg, color) {
	instance_create_depth(screen_width-123, 38, 0, obj_hud_message, {
		"color": color,
		"message": msg
	})
}

show_annotations = function() {
	display_annotations = true
	annotations_offset = 40
}

hide_annotations = function() {
	display_annotations = false
}