enum player_controls {
	moving,
	looking,
	interaction,
	inventory,
	focusing,
	auto_move,
	standing_up,
	collision_overflow_correction
}

WALK_SPEED = 3
RUN_SPEED = 25
SIGHT_RANGE = 175
EYE_HEIGHT_STANDING = 115
EYE_HEIGHT_SITTING = 85

eye_height = EYE_HEIGHT_STANDING
actor_hover = noone
focus = noone
can_move = true
can_look = true
can_interact = true
lock_move = false
lock_look = false
lock_interact = false
inventory = []
active_hints = []
completed_hints = []
inventory_item_selected_index = 0
inventory_item_selected = noone
inventory_item_selected_enabled = true
bbox_list = [bbox_create(-8, -8, -135, 8, 8, 0)]
ts_item_selected_reenable = time_source_create(time_source_global, 1, time_source_units_frames, function() {})
is_moving_auto = false
move_auto_coord = -1
move_auto_speed = WALK_SPEED
move_auto_callback = undefined
door_passing = noone
has_finished_tasks = false
last_door_passed = noone
sitting_place = undefined
is_standing_up = false
stop_focusing_auto = false
use_collision_overflow_correction = true

camera = actor_3d_create(x, y, z-eye_height, obj_camera_3d_generic, {
	limit_pitch: true,
	pitch_min: -80,
	pitch_max: 80,
	fov_y: 85
});

cursor_wave = instance_create_depth(0, 0, 0, obj_wave, {
	amplitude: 3.5
});

raycaster = instance_create_depth(0, 0, 0, obj_raycaster, {
	max_distance: SIGHT_RANGE,
	jump: 4,
	target: obj_interactable_generic,
	x_func: function() { return obj_player.camera.x },
	y_func: function() { return obj_player.camera.y },
	z_func: function() { return obj_player.camera.z+16 },
	yaw_func: function() { return obj_player.camera.yaw },
	pitch_func: function() { return obj_player.camera.pitch },
	callback: function(inst) { obj_player.actor_hover = inst }
});

pass_through_door = function(xpos, ypos, door, spd=WALK_SPEED) {
	move_to(xpos, ypos, spd)
	door_passing = door
	last_door_passed = door
	actor_hover = noone
	
	if (door_passing.door_number != -1) {
		resolve_hint(hint_types.go_to_room, door_passing.door_number)	
	}
}

cancel_movement = function() {
	can_move = true
	can_look = true
	can_interact = true
	is_moving_auto = false
}

move_to = function(xpos, ypos, spd=WALK_SPEED, callback=undefined) {
	is_moving_auto = true
	move_auto_speed = spd
	move_auto_coord = [xpos, ypos]
	move_auto_callback = callback
}

move = function(callback, move_speed) {
	var offset, xoffset, yoffset;
	
	offset = [0, 0];
	
	callback(offset, move_speed);
	
	xoffset = offset[0];
	yoffset = offset[1];
	
	if (xoffset != 0 || yoffset != 0) {
		var offset_length, xspeed, yspeed;
	
		offset_length = sqrt(sqr(xoffset) + sqr(yoffset));

		xspeed = xoffset/offset_length*move_speed;
		yspeed = yoffset/offset_length*move_speed;
	
		if (!place_meeting_3d(x + xspeed, y, z, obj_actor_3d_generic)) {
			x += xspeed;
		}
	
		if (!place_meeting_3d(x, y + yspeed, z, obj_actor_3d_generic)) {
			y += yspeed;
		}
	}
}
	
talk_to = function(npc) {
	resolve_hint(hint_types.talk_to_someone, npc.name);
	
	if (string_length(npc.dialogue) == 0) {
		var probability_give_hint = 1/6 * npc.helpfulness
		var give_hint = take_chance(probability_give_hint)
	
		if (give_hint) {
			npc_give_hint(npc, array_choose(hint_types_list))
			return;
		} 
	
		npc.dialogue = array_choose(default_dialogues.miscelaneous)
	}
	
	if (!audio_is_playing(obj_espeak_control.audio_buffer)) {
		npc_speak(npc)
	}
}	

receive_hint = function(hint_type, args) {
	array_push(active_hints[hint_type], args)
	
	show_debug_message(active_hints)
}

resolve_hint = function(hint_type, comparer) {
	var hint = remove_hint(hint_type, comparer)
	
	if (!is_undefined(hint)) {
		array_push(completed_hints, serialize_hint(hint_type, comparer))
		var desc = get_hint_description(hint_type, hint)
		obj_hud.add_message($"Completed: \"{desc}\"", c_ltgreen)
		
		if (array_length(completed_hints) > 2) {
			has_finished_tasks = true
		}
	}
	
	return hint
}

remove_hint = function(hint_type, comparer) {
	var hints, index, hint
	
	hints = active_hints[hint_type]
	
	index = array_find_index(hints, method({ comparer: comparer }, function(item) {
		return is_array(item) ? item[0] == comparer : item == comparer
	}));
	
	if (index == -1) {
		return undefined
	}
	
	hint = hints[index]
	array_delete(hints, index, 1)

	return hint
}

fail_hint = function(hint_type, comparer) {
	var hint = remove_hint(hint_type, comparer)
	
	if (!is_undefined(hint)) {
		var desc = get_hint_description(hint_type, hint)
		obj_hud.add_message($"Failed: \"{desc}\"", c_red)
	}
	
	return hint
}
	
revert_hint = function(hint_type, hint) {
	var comparer = is_array(hint) ? hint[0] : hint
	var hint_formatted = serialize_hint(hint_type, comparer)
	
	var index = array_find_index(completed_hints, method({ hint_formatted: hint_formatted }, function(item) {
		return item == hint_formatted
	}));
	
	if (index == -1) {
		return undefined
	}
	
	var desc = get_hint_description(hint_type, hint)
	obj_hud.add_message($"Revoked: \"{desc}\"", c_yellow)
	obj_player.receive_hint(hint_type, hint)
	
	array_delete(completed_hints, index, 1)
}

serialize_hint = function(hint_type, comparer) {
	return $"{hint_type}_{comparer}"	
}

receive_item = function(item) {
	var resolved = obj_player.resolve_hint(hint_types.find_item, item.name)
		
	if (is_undefined(resolved)) {
		obj_hud.add_message(item.name + " has been added to your inventory", c_yellow)	
	}
		
	obj_hud.inventory_temp = inventory
	inventory_item_selected_index = item.index
	obj_hud.scale_inventory_item_selected()
}
	
update_camera_position = function() {
	camera.x = x;
	camera.y = y;
	camera.z = z-eye_height;
}

get_hint_description = function(hint_type, arg) {
	switch (hint_type) {
		case hint_types.find_item:
			return $"Find {arg[0]}"
			
		case hint_types.go_back_one_room:
			return "Go back the way you came"
			
		case hint_types.go_to_room:
			return $"Go to room {arg}"
			
		case hint_types.talk_to_someone:
			return $"Talk to {arg[0]}"
			
		case hint_types.go_to_another_floor:
			return $"Go {(arg[1] == stairs_directions.down ? "down" : "up")}stairs"
	}
}

get_hints_descriptions = function() {
	var descriptions = []
	
	array_foreach(hint_types_list, method({ descriptions: descriptions }, function(hint_type) {
		var state = {
			descriptions: descriptions,
			hint_type: hint_type
		}
		
		array_foreach(obj_player.active_hints[hint_type], method(state, function(arg) {
			array_push(descriptions, obj_player.get_hint_description(hint_type, arg))
		}))
	}))
	
	return descriptions
}

inventory_add_item = function(item, use_animation = true, index = -1) {
	var spr
	
	var item_name = object_get_name(item.object_index)
	var inventory_item = undefined
	var n_items = array_length(inventory)
	
	for (var i = 0; i < n_items; i++) {
		if (inventory[i].object_name == item_name) {
			inventory_item = inventory[i]
			index = i
			break
		}
	}
	
	obj_hud.inventory_temp = []
		
	for (var i = 0; i < n_items; i++) {
		array_push(obj_hud.inventory_temp, struct_duplicate(inventory[i]))
	}
	
	if (is_undefined(inventory_item)) {	
		var spr_w = sprite_get_width(item.sprite_index)
		var spr_h = sprite_get_height(item.sprite_index)
		var spr_original = sprite_part_copy(item.sprite_index, 0, 0, 0, spr_w, spr_h, spr_w*.5, spr_h*.5)
	
		if (spr_w == INVENTORY_ITEM_SIZE) {
			spr = spr_original
		} else {
			var scale = INVENTORY_ITEM_SIZE/spr_w
		
			var spr_scaled = sprite_get_scaled(item.sprite_index, scale, scale)
		
			spr = sprite_part_copy(spr_scaled, 0, 0, 0, spr_w * scale, spr_h * scale, spr_w*.5 * scale, spr_h*.5 * scale)
		}
		
		index = index >= 0 ? index : array_length(inventory)
	
		inventory_item = {
			"object_name": item_name,
			"object": item.object_index,
			"number": item.quantity,
			"index": index,
			"name": item.name,
			"sprite": spr,
			"sprite_original": spr_original,
			"can_combine": item.can_combine,
			"on_select": item.on_select,
			"on_unselect": item.on_unselect
		}
		
		array_insert(inventory, index, inventory_item)
	} else {
		inventory_item.number += item.quantity
	}
	
	if (use_animation) {
		obj_hud.set_item_picked(index, inventory_item.sprite, item.name)	
	} else {
		obj_hud.inventory_temp = inventory
	}
	
	return inventory_item
}
	
inventory_find_item = function(object) {
	object = object_get_index(object)
	
	var index = array_find_index(inventory, method({ object: object }, function(item) {
		return item.object == object	
	}))
	
	if (index >= 0) {
		return inventory[index]	
	}
	
	return noone
}

inventory_set_item = function(item) {
	item = object_get_index(item)
	
	var inventory_item = inventory_find_item(item)
	
	if (inventory_item == noone) {
		throw "Item not found in inventory"	
	}
	
	inventory_item_selected = inventory_item
	inventory_item_selected_index = inventory_item.index
	
	obj_hud.scale_inventory_item_selected()
}

inventory_remove_item = function(item, unselect = true) {
	var obj_item = object_get_index(item)
	
	var index = array_find_index(inventory, method({ obj_item: obj_item }, function(inventory_item) {
		return inventory_item.object == obj_item
	}))
	
	if (index == -1) {
		show_debug_message($"Item of type {obj_item} not found in inventory.")
		return
	}
	
	var count = inventory[index].number - 1
	var is_selected = inventory_item_selected != noone && inventory_item_selected.object == obj_item
	
	if (inventory[index].number > 1) {
		inventory[index].number--	
	} else {
		if (inventory[index].sprite != inventory[index].sprite_original) {
			sprite_delete(inventory[index].sprite_original)	
		}
		
		sprite_delete(inventory[index].sprite)
		
		array_delete(inventory, index, 1)
		
		if (is_selected && inventory_item_selected_index > 0) {
			inventory_item_selected_index--
			
		}
	}
	
	if (is_selected) {
		obj_cursor.sprite_index = -1
		obj_cursor.draw_as_gui = true
		
		if (unselect) {
			inventory_item_selected = noone
		}
	}
	
	return count
}

pick_item = function(item) {
	inventory_add_item(item)
	item.active = false
	item.on_picked();
	actor_hover = noone
	raycaster_clear(raycaster)
	instance_destroy(item)
}
	
get_hinted_door = function() {
	if (array_length(active_hints[hint_types.go_to_room]) == 0) {
		return -1;	
	}
	
	return active_hints[hint_types.go_to_room][0];
}

cursor_set_to_item_selected = function(enabled=true, reenable_period=1) {
	var xoffset, yoffset, sprite, scale, scale_factor;
	
	sprite = inventory_item_selected.sprite_original;
	scale_factor = INVENTORY_ITEM_SIZE / sprite_get_width(sprite)
	scale = (enabled ? 4 : 1.5) * scale_factor;
	scale = 0.5;
	xoffset = sprite_get_draw_center_x(sprite, scale);
	yoffset = sprite_get_draw_center_y(sprite, scale) + enabled ? 295 : 0;
		
	cursor_set_sprite(sprite, scale, 1, enabled, xoffset, yoffset);
	
	if (enabled) inventory_item_selected_enabled = true;
	else {
		time_source_reconfigure(ts_item_selected_reenable, reenable_period, time_source_units_frames, function() {
			obj_cursor.enabled = true;
			inventory_item_selected_enabled = true;
		})
		
		time_source_start(ts_item_selected_reenable);
		inventory_item_selected_enabled = false;
	}
}

sit = function(place, bbox_index=0) {
	var bbox = place.bbox_list[bbox_index]
	var center = bbox_get_center(bbox, place.transformation_matrix)
	var rot = place.zrotation + 270
	
	can_interact = false
	can_move = false
	
	x = center[0]
	y = center[1]
	z = place.z
	camera.yaw = rot
	camera.pitch = 0
	
	sitting_place = place
	
	camera.pitch_min = -7
	camera.limit_yaw = true
	camera.yaw_min = rot-70
	camera.yaw_max = rot+70
	
	use_collision_overflow_correction = false
}

stand = function() {
	is_standing_up = true
	
	camera.limit_yaw = false
	camera.pitch_min = -80
	camera.pitch_max = 80
}

array_foreach(hint_types_list, function(hint_type) {
	array_push(active_hints, [])		
})

raycaster_start(raycaster);
event_inherited();