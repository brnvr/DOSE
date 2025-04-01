enum player_events {
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
RUN_SPEED = 6
SIGHT_RANGE = 175
EYES_HEIGHT_STANDING = 115
EYES_HEIGHT_SITTING = 85
TASKS_TO_FINISH = 3
MAX_NON_LETHAL_ENVENOMING = .55

stamina = 1
actor_hover = noone
eyes_height = EYES_HEIGHT_STANDING
is_answering = false
focus = noone
can_move = true
can_look = true
can_interact = true
envenoming = 0
envenoming_fade = noone
lock_move = false
lock_look = false
lock_interact = false
inventory = []
active_tasks = []
completed_tasks = []
inventory_item_selected_index = 0
inventory_item_selected = noone
inventory_item_selected_enabled = true
bbox_list = [bbox_create(-8, -8, -135, 8, 8, 0)]
ts_item_selected_reenable = time_source_create(time_source_global, 1, time_source_units_frames, do_nothing)
is_moving = false
is_moving_on_staircase = false
is_moving_auto = false
move_auto_coord = -1
move_auto_speed = WALK_SPEED
on_move_auto = undefined
door_passing = noone
has_finished_tasks = false
last_door_passed = noone
is_resetting_stamina = false
sitting_place = undefined
is_standing_up = false
stop_focusing_auto = false
use_collision_overflow_correction = true
npcs_met = []

camera = actor_3d_create(x, y, z-eyes_height, obj_camera_3d_generic, {
	pitch_min: -80,
	pitch_max: 80,
	fov_y: 85,
	limit_pitch: true
})

cursor_wave = instance_create_depth(0, 0, 0, obj_wave, {
	amplitude: 3.5
})

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
})

interact_with_antivenom = function() {
	if (envenoming == 0) {
		obj_hud.show_notification("You don't need it right now.")
			
		return
	}
		
	take_antivenom()
	inventory_remove_item(obj_antivenom)
}

interact_with_currant_syrup = function() {
	audio_play_sound(snd_sip, false, false)
	inventory_remove_item(obj_currant_syrup)
	obj_hud.show_notification("Is this real? (stamina increased)")
	stamina = 2
	event_schedule(20, time_source_units_seconds, function() {
		obj_player.reset_stamina()
	})
}

reset = function() {
	can_move = true
	can_look = true
	can_interact = true
	lock_move = false
	lock_look = false
	lock_interact = false
	focus = noone
	is_moving = false
	is_moving_on_staircase = false
	is_moving_auto = false
	is_standing_up = false
	stop_focusing_auto = false
}

reset_stamina = function() {
	is_resetting_stamina = true
}	

interactions_list = [
	[obj_antivenom, interact_with_antivenom],
	[obj_currant_syrup, interact_with_currant_syrup]
]

take_damage = function() {
	if (!instance_exists(obj_blood_overlay)) {
		instance_create_layer(0, 0, "Abstract", obj_blood_overlay)		
	}
}

pass_through_door = function(xpos, ypos, door, spd=WALK_SPEED) {
	move_to(xpos, ypos, spd)
	door_passing = door
	last_door_passed = door
	actor_hover = noone
	
	if (door_passing.door_number != -1) {
		resolve_task(task_types.go_to_room, door_passing.door_number)	
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
	on_move_auto = callback
}

move = function(callback, move_speed) {
	var offset = [0, 0]
	
	callback(offset, move_speed)
	
	var xoffset = offset[0]
	var yoffset = offset[1]
	
	if (xoffset != 0 || yoffset != 0) {
		var offset_length, xspeed, yspeed
		
		is_moving = true
	
		offset_length = sqrt(sqr(xoffset) + sqr(yoffset))

		xspeed = xoffset/offset_length*move_speed
		yspeed = yoffset/offset_length*move_speed
	
		if (!place_meeting_3d(x + xspeed, y, z, obj_actor_3d_generic)) {
			x += xspeed
		}
	
		if (!place_meeting_3d(x, y + yspeed, z, obj_actor_3d_generic)) {
			y += yspeed
		}
	}
}
	
talk_to = function(npc) {
	if (has_met_npc(npc) || npc.introductory_dialogue == "") {
		var should_give_quest = random_event(npc.prob_give_quest)
	
		if (should_give_quest) {
			npc.options = [
				["Yes"],
				["No"]
			]
			
			npc.dialogue = npc.quest_dialogue
			
			npc_speak(npc, true, true)
		}	
	}
	
	if (array_length(npc.options) > 0) {
		is_answering = true
		npc_show_options(npc)
		can_move = false
		can_look = false
		focus = npc
		actor_hover = noone
		cursor_set_sprite(spr_cursor_arrow)
		instance_deactivate_object(raycaster)
	} else {
		resolve_task(task_types.talk_to_someone, variable_static_get(npc.object_index, "name"))
	
		if (npc.keep_focus) {
			focus = npc
			can_move = false
			can_interact = false
			cursor_set_sprite(noone)
		}
	
		if (!has_met_npc(npc)) {
			meet_npc(npc)
		}
	
		if (string_length(npc.dialogue) == 0) {
			var probability_give_task = 1/6 * npc.helpfulness
			var should_give_task = random_event(probability_give_task)
	
			if (should_give_task) {
				npc_give_task(npc, array_choose(global.task_types_list))
				
				return
			} 
	
			npc.dialogue = array_choose(npc.dialogues_source.miscelaneous)[$ obj_settings.language]
		}
	
		npc_speak(npc)	
	}
}	

receive_task = function(task_type, args) {
	array_push(active_tasks[task_type], args)
}

resolve_task = function(task_type, comparer) {
	var task = remove_task(task_type, comparer)
	
	if (!is_undefined(task)) {
		var is_progressive_task = array_contains(global.progressive_task_types, task_type)
		
		if (is_progressive_task) {
			array_push(completed_tasks, serialize_task(task_type, comparer))
		
			if (array_length(completed_tasks) >= TASKS_TO_FINISH) {
				has_finished_tasks = true
			}	
		}
		
		var desc = get_task_description(task_type, task)
		
		obj_hud.show_notification($"Completed: \"{desc}\"")
	}
	
	return task
}

remove_task = function(task_type, comparer) {
	var tasks = active_tasks[task_type]
	
	var index = array_find_index(tasks, method({ comparer: comparer }, function(item) {
		return is_array(item) ? item[0] == comparer : item == comparer
	}))
	
	if (index == -1) {
		return undefined
	}
	
	var task = tasks[index]
	array_delete(tasks, index, 1)

	return task
}

fail_task = function(task_type, comparer) {
	var task = remove_task(task_type, comparer)
	
	if (!is_undefined(task)) {
		var desc = get_task_description(task_type, task)
		obj_hud.show_notification($"Failed: \"{desc}\"")
	}
	
	return task
}
	
revert_task = function(task_type, task) {
	var comparer = is_array(task) ? task[0] : task
	var task_formatted = serialize_task(task_type, comparer)
	
	var index = array_find_index(completed_tasks, method({ task_formatted: task_formatted }, function(item) {
		return item == task_formatted
	}))
	
	if (index == -1) {
		return undefined
	}
	
	var desc = get_task_description(task_type, task)
	obj_hud.show_notification($"Revoked: \"{desc}\"")
	obj_player.receive_task(task_type, task)
	
	array_delete(completed_tasks, index, 1)
}

serialize_task = function(task_type, comparer) {
	return $"{task_type}_{comparer}"	
}

receive_item = function(item) {
	var resolved = obj_player.resolve_task(task_types.find_item, item.name)
		
	if (is_undefined(resolved)) {
		obj_hud.show_notification(item.name + " has been added to your inventory")
	}
		
	obj_hud.inventory_temp = inventory
	inventory_item_selected_index = item.index
	obj_hud.scale_inventory_item_selected()
}
	
update_camera_position = function() {
	camera.x = x
	camera.y = y
	camera.z = z-eyes_height
}

get_task_description = function(task_type, arg) {
	switch (task_type) {
		case task_types.find_item:
			return $"Find {arg[0]}"
			
		case task_types.go_back_one_room:
			return "Go back the way you came"
			
		case task_types.go_to_room:
			return $"Go to room {arg}"
			
		case task_types.talk_to_someone:
			return $"Talk to {arg[0]}"
			
		case task_types.go_to_another_floor:
			return $"Go {(arg[1] == stairs_directions.down ? "down" : "up")}stairs"
	}
}

get_tasks_descriptions = function() {
	var descriptions = []
	
	array_foreach(global.task_types_list, method({ descriptions }, function(task_type) {
		var state = {
			descriptions: descriptions,
			task_type: task_type
		}
		
		array_foreach(obj_player.active_tasks[task_type], method(state, function(arg) {
			array_push(descriptions, obj_player.get_task_description(task_type, arg))
		}))
	}))
	
	return descriptions
}

pick_item = function(item) {
	inventory_add_item(item)
	item.active = false
	item.on_picked()
	actor_hover = noone
	raycaster_clear(raycaster)
	
	if (item.pickup_sound != noone) {
		audio_play_sound(item.pickup_sound, false, false)	
	}
	
	instance_destroy(item)
}
	
get_tasked_door = function() {
	if (array_length(active_tasks[task_types.go_to_room]) == 0) {
		return -1;	
	}
	
	return active_tasks[task_types.go_to_room][0];
}

cursor_set_to_item_selected = function(enabled=true, reenable_period=1) {
	var sprite = inventory_item_selected.sprite_held;
	var scale_factor = INVENTORY_ITEM_SIZE / sprite_get_width(sprite)
	//scale = (enabled ? 4 : 1.5) * scale_factor
	var scale = 0.5
	var xoffset = sprite_get_draw_center_x(sprite, scale)
	var yoffset = sprite_get_draw_center_y(sprite, scale) + enabled ? 295 : 0
		
	cursor_set_sprite(sprite, scale, 1, enabled, xoffset, yoffset)
	
	if (enabled) {
		inventory_item_selected_enabled = true
	} else {
		time_source_reconfigure(ts_item_selected_reenable, reenable_period, time_source_units_frames, function() {
			obj_cursor.enabled = true
			inventory_item_selected_enabled = true
		})
		
		time_source_start(ts_item_selected_reenable)
		inventory_item_selected_enabled = false
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
	
	update_camera_position()
	
	camera.yaw = rot
	camera.pitch = 0
	
	sitting_place = place
	
	camera.pitch_min = -7
	camera.limit_yaw = true
	camera.yaw_min = rot-70
	camera.yaw_max = rot+70
	
	obj_hud.caption = ""
	obj_hud.subcaption = ""
	
	use_collision_overflow_correction = false
}

stand_up = function() {
	is_standing_up = true
	
	camera.limit_yaw = false
	camera.pitch_min = -80
	camera.pitch_max = 80
}

get_envenomated = function() {
	envenoming = min(1, envenoming + 0.25)
	
	var envenoming_fade_out = instance_create_layer(0, 0, "Abstract", obj_fade_out, {
		spd: 0.0007*envenoming,
		on_complete: function() {
			game_reset(0.25)
			
			with (obj_player) {
				can_move = false
				can_look = false
				can_interact = false
				obj_cursor.visible = false
			
				heal_from_envenomation(false, 3, function() {
					can_move = true
					can_look = true
					can_interact = true
					obj_cursor.visible = true
					
					cursor_center()
					cursor_pause_sync(1)
					
					with (obj_doorman) {
						on_finish_talking = do_nothing
						keep_focus = false
						dialogue = "We're having a problem with spiders, but a professional exterminator is already taking care of the matter."
					}
				})
			}
		}
	})
	
	if (instance_exists(envenoming_fade)) {
		envenoming_fade_out.alpha = envenoming_fade.alpha
		
		instance_destroy(envenoming_fade)	
	}
	
	envenoming_fade = envenoming_fade_out
	
	take_damage()
	obj_hud.show_notification("Envenomated")
	
	var get_envenoming = function() { return obj_player.envenoming }
	
	vfx_set_filter(fx_filter_types.losing_consciousness, get_envenoming)
	afx_set_filter(fx_filter_types.losing_consciousness, get_envenoming)
}

heal_from_envenomation = function(fade_in=true, total_time_seconds=15, callback=do_nothing) {
	var envenoming_fade_in = noone
	
	if (fade_in) {
		envenoming_fade_in = instance_create_layer(0, 0, "Abstract", obj_fade_in, {
			spd: 0.001,
			alpha: envenoming_fade.alpha,
			on_complete: method(obj_player, function() {
				instance_destroy(envenoming_fade)
			
				envenoming_fade = noone
			})
		})	
	}
	
	envenoming = 0	
	instance_destroy(envenoming_fade)
	
	if (fade_in) {
		envenoming_fade = envenoming_fade_in	
	}
	
	vfx_reset_filter(fx_filter_types.losing_consciousness, total_time_seconds, callback)
	afx_reset_filter(fx_filter_types.losing_consciousness, total_time_seconds)
}

take_antivenom = function() {
	heal_from_envenomation()
	obj_hud.show_notification("Received antivenom. You'll be fine soon.")	
}

meet_npc = function(npc) {
	array_push(npcs_met, npc.object_index)	
}

has_met_npc = function(npc) {
	return array_contains(npcs_met, npc.object_index)
}

array_foreach(global.task_types_list, function(task_type) {
	array_push(active_tasks, [])		
})

raycaster_start(raycaster)
event_inherited()
	