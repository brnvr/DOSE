function npc_give_task(npc, task_type) {
	static go_to_room_task = function(npc) {
		var door_number = undefined
		
		if (array_length(obj_player.active_tasks[task_types.go_to_room]) == 0) {
			door_number = array_choose(obj_control.door_numbers_avaliable)
			obj_player.receive_task(task_types.go_to_room, door_number)
		} else {
			door_number = obj_player.active_tasks[task_types.go_to_room][0]
		}
		
		var dialogue = array_choose(npc.dialogues_source.tasks[task_types.go_to_room])[$ obj_settings.language]
		dialogue = replace_placeholder(dialogue, "door_number", string(door_number))
		
		return dialogue
	}
	
	static go_back_one_room_task = function(npc) {
		if (obj_player.last_door_passed == noone) {
			return "..."	
		}
		
		if (array_length(obj_player.active_tasks[task_types.go_back_one_room]) == 0) {
			obj_player.receive_task(task_types.go_back_one_room, obj_player.last_door_passed)
		}
		
		obj_player.last_door_passed.revert_task = true
		obj_player.last_door_passed.revert_task_opposite_area = obj_control.current_area

		return array_choose(npc.dialogues_source.tasks[task_types.go_back_one_room])[$ obj_settings.language]
	}
	
	static talk_to_someone_task = function(npc) {
		var dialogue = ""
		var npc_other_name = ""
		var npc_other_pronouns = undefined
		
		var arr_tasks = obj_player.active_tasks[task_types.talk_to_someone]
		
		if (array_length(arr_tasks) == 0) {
			var npc_other_obj = noone
			var characters = obj_control.seed_group[sg.characters]
			var n_characters = array_length(characters)

			if (n_characters > 2) {
				do {
					npc_other_obj = array_choose(characters)
				}
				until (npc_other_obj != npc.object_index)
			} else if (n_characters == 2) {
				npc_other_obj = characters[0] == npc_other_obj.object_index ? characters[1] : characters[0]
			} else if (n_characters == 1) {
				npc_other_obj = [0]
			
				if (npc_other_obj == npc.object_index) {
					throw "No other characters avaliable in the seed group."	
				}
			} else {
				throw "No characters avaliable in the seed group."		
			}
		
			npc_other_name = variable_static_get(npc_other_obj, "name")
			npc_other_pronouns = variable_static_get(npc_other_obj, "pronouns")
			
			obj_player.receive_task(task_types.talk_to_someone, [npc_other_name, npc_other_pronouns])
		}
		else {
			npc_other_name = arr_tasks[0][0]
			npc_other_pronouns = arr_tasks[0][1]
		}
		
		dialogue = array_choose(npc.dialogues_source.tasks[task_types.talk_to_someone])[$ obj_settings.language]
		dialogue = replace_placeholder(dialogue, "name", string(npc_other_name))
		dialogue = replace_placeholder(dialogue, "s_pronoun", string(npc_other_pronouns[pronoun_type.subject]))
		dialogue = replace_placeholder(dialogue, "o_pronoun", string(npc_other_pronouns[pronoun_type.object]))
		
		return dialogue
	}
		
	static find_item_task = function(npc) {
		var items = obj_control.seed_group[sg.items]
		var item = array_choose(items)
		var arr_tasks = obj_player.active_tasks[task_types.find_item]
		var n_tasks = array_length(arr_tasks)
		var inventory_length = array_length(obj_player.inventory)
		var item_name = variable_static_get(item, "name")
		
		for (var i = 0; i < inventory_length; i++) {
			var inventory_item = obj_player.inventory[i]
			
			if (inventory_item.name == item_name) {
				return "..."	
			}
		}
		
		for (var i = 0; i < n_tasks; i++) {
			var task = arr_tasks[i]
			
			if (task[0] == item_name) {
				return "..."	
			}
		}

		var name_article = variable_static_get(item, "article")

		obj_player.receive_task(task_types.find_item, [item_name, name_article])
		
		var dialogue = array_choose(npc.dialogues_source.tasks[task_types.find_item])[$ obj_settings.language]
		dialogue = replace_placeholder(dialogue, "name", string(item_name))
		dialogue = replace_placeholder(dialogue, "article", string(name_article))
		
		return dialogue
	}
		
	static complete_quest_task = function(npc) {
		var n_quests = array_length(npc.quests)
		
		if (n_quests == 0) {
			return "..."	
		}
		
		var tasks_state = {
			npc: npc,
			npc_quest: noone
		}
		
		var arr_tasks = obj_player.active_tasks[task_types.complete_quest]
		
		array_foreach(arr_tasks, method(tasks_state, function(item) {
			if (item[1] == npc) {
				npc_quest = item[0]
				return
			}
		}))
		
		if (tasks_state.npc_quest != noone) {
			return tasks_state.npc_quest[quest_props.npc_dialogue]
		}
		
		var quest = array_choose(npc.quests, false)
		
		quest[quest_props.action]()
		obj_player.receive_task(task_types.complete_quest, [quest, npc])
		
		return quest[quest_props.npc_dialogue]
	}
	
	static go_to_another_floor_task = function(npc) {
		var dir = undefined
		var dialogue = array_choose(npc.dialogues_source.tasks[task_types.go_to_another_floor])[$ obj_settings.language]	
		var arr_tasks = obj_player.active_tasks[task_types.go_to_another_floor]
		
		if (array_length(arr_tasks) == 0) {
			dir = choose(stairs_directions.up, stairs_directions.down)
			
			var floor_destination = obj_control.current_floor + (dir == stairs_directions.up ? 1 : -1)
			
			obj_player.receive_task(task_types.go_to_another_floor, [floor_destination, dir]);
		} else {
			dir = arr_tasks[0][1]
		}
	
		switch(dir) {
			case stairs_directions.up:
				return replace_placeholder(dialogue, "direction", "up")
				
			case stairs_directions.down:
				return replace_placeholder(dialogue, "direction", "down")
				
			default:
				throw "Invalid direction"
		}
	}
	
	switch (task_type) {
		case task_types.find_item:
			npc.dialogue = find_item_task(npc)
			break
			
		case task_types.go_to_room:
			npc.dialogue = go_to_room_task(npc)
			break
				
		case task_types.go_back_one_room:
			npc.dialogue = go_back_one_room_task(npc)	
			break
			
		case task_types.talk_to_someone:
			npc.dialogue = talk_to_someone_task(npc)
			break
			
		case task_types.go_to_another_floor:
			npc.dialogue = go_to_another_floor_task(npc)
			break
			
		case task_types.complete_quest:
			npc.dialogue = complete_quest_task(npc)
			break
	}
	
	return npc_speak(npc)
}