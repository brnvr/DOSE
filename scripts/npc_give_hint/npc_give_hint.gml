function npc_give_hint(npc, hint_type) {
	static go_to_room_hint = function() {
		var door_number = undefined
		
		if (array_length(obj_player.active_hints[hint_types.go_to_room]) == 0) {
			door_number = array_choose(obj_control.door_numbers_avaliable)
			obj_player.receive_hint(hint_types.go_to_room, door_number)
		} else {
			door_number = obj_player.active_hints[hint_types.go_to_room][0]
		}
		
		var dialogue = array_choose(global.default_dialogues.hints[hint_types.go_to_room])
		dialogue = replace_placeholder(dialogue, "door_number", string(door_number))
		
		return dialogue;
	}
	
	static go_back_one_room_hint = function() {
		if (obj_player.last_door_passed == noone) {
			return "..."	
		}
		
		if (array_length(obj_player.active_hints[hint_types.go_back_one_room]) == 0) {
			obj_player.receive_hint(hint_types.go_back_one_room, obj_player.last_door_passed)
		}
		
		obj_player.last_door_passed.revert_hint = true
		obj_player.last_door_passed.revert_hint_opposite_area = obj_control.current_area

		return array_choose(global.default_dialogues.hints[hint_types.go_back_one_room])
	}
	
	static talk_to_someone_hint = function(npc) {
		var dialogue = ""
		var npc_other_name = ""
		var npc_other_pronouns = undefined
		
		var arr_hints = obj_player.active_hints[hint_types.talk_to_someone]
		
		if (array_length(arr_hints) == 0) {
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
		
			npc_other_name = global.names[npc_other_obj][0]
			npc_other_pronouns = global.names[npc_other_obj][1]
			
			obj_player.receive_hint(hint_types.talk_to_someone, [npc_other_name, npc_other_pronouns])
		}
		else {
			npc_other_name = arr_hints[0][0]
			npc_other_pronouns = arr_hints[0][1]
		}
		
		dialogue = array_choose(global.default_dialogues.hints[hint_types.talk_to_someone])
		dialogue = replace_placeholder(dialogue, "name", string(npc_other_name))
		dialogue = replace_placeholder(dialogue, "s_pronoun", string(npc_other_pronouns[0]))
		dialogue = replace_placeholder(dialogue, "o_pronoun", string(npc_other_pronouns[1]))
		
		return dialogue
	}
		
	static find_item_hint = function() {
		var items = obj_control.seed_group[sg.items]
		var item = array_choose(items)
		var arr_hints = obj_player.active_hints[hint_types.find_item]
		var n_hints = array_length(arr_hints)
		var inventory_length = array_length(obj_player.inventory)
		var item_name = global.names[item][0]
		
		for (var i = 0; i < inventory_length; i++) {
			var inventory_item = obj_player.inventory[i]
			
			if (inventory_item.name == item_name) {
				return "..."	
			}
		}
		
		for (var i = 0; i < n_hints; i++) {
			var hint = arr_hints[i]
			
			if (hint[0] == item_name) {
				return "..."	
			}
		}

		var name_article = global.names[item][1]

		obj_player.receive_hint(hint_types.find_item, [item_name, name_article])
		
		var dialogue = array_choose(global.default_dialogues.hints[hint_types.find_item])
		dialogue = replace_placeholder(dialogue, "name", string(item_name))
		dialogue = replace_placeholder(dialogue, "article", string(name_article))
		
		return dialogue
	}
		
	static fulfill_quest_hint = function(npc) {
		var n_quests = array_length(npc.quests)
		
		if (n_quests == 0) {
			return "..."	
		}
		
		var hints_state = {
			npc: npc,
			npc_quest: noone
		}
		
		var arr_hints = obj_player.active_hints[hint_types.fulfill_quest]
		
		array_foreach(arr_hints, method(hints_state, function(item) {
			if (item[1] == npc) {
				npc_quest = item[0]
				return
			}
		}))
		
		if (hints_state.npc_quest != noone) {
			return hints_state.npc_quest[quest_props.npc_dialogue]
		}
		
		var quest = array_choose(npc.quests, false)
		
		quest[quest_props.action]()
		obj_player.receive_hint(hint_types.fulfill_quest, [quest, npc])
		
		return quest[quest_props.npc_dialogue]
	}
	
	static go_to_another_floor_hint = function() {
		var dir = undefined
		var dialogue = array_choose(global.default_dialogues.hints[hint_types.go_to_another_floor])	
		var arr_hints = obj_player.active_hints[hint_types.go_to_another_floor]
		
		if (array_length(arr_hints) == 0) {
			dir = choose(stairs_directions.up, stairs_directions.down)
			
			var floor_destination = obj_control.current_floor + (dir == stairs_directions.up ? 1 : -1)
			
			obj_player.receive_hint(hint_types.go_to_another_floor, [floor_destination, dir]);
		} else {
			dir = arr_hints[0][1]
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
	
	switch (hint_type) {
		case hint_types.find_item:
			npc.dialogue = find_item_hint()
			break
			
		case hint_types.go_to_room:
			npc.dialogue = go_to_room_hint()
			break
				
		case hint_types.go_back_one_room:
			npc.dialogue = go_back_one_room_hint()	
			break
			
		case hint_types.talk_to_someone:
			npc.dialogue = talk_to_someone_hint(npc)
			break
			
		case hint_types.go_to_another_floor:
			npc.dialogue = go_to_another_floor_hint()
			break
			
		case hint_types.fulfill_quest:
			npc.dialogue = fulfill_quest_hint(npc)
			break
	}
	
	return npc_speak(npc)
}