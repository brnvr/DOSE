interactable_set_interaction(id, obj_vhs_tape, function() {
	inventory_remove_item(obj_vhs_tape)
	obj_hud.show_notification("VHS tape given to Roger")
})

npc_set_dialogues_task(id, task_types.talk_to_someone, [
	{
		"en": "ksjdka asas asasaskjksajd"
	}
])

npc_set_dialogues_task(id, task_types.find_item, [
	{
		"en": "ksjdkaskjasasd asasa asksajd"
	}
])

npc_set_dialogues_task(id, task_types.go_back_one_room, [
	{
		"en": "ksjdkaskjkasad aaasad sajd"
	}
])

npc_set_dialogues_task(id, task_types.go_to_another_floor, [
	{
		"en": "ksjdkask assad aaajksajd"
	}
])

npc_set_dialogues_task(id, task_types.go_to_room, [
	{
		"en": "ksjaa aaasd aaaskjksajd"
	}
])

event_inherited()