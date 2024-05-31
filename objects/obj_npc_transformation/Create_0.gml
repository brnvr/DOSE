count = max_count;
is_blinking = false;

ts_blink = time_source_create(time_source_global, 7, time_source_units_frames, function() {
	is_blinking = false;
	npc.sprite_index = npc_sprite;
});

npc.is_transforming = true;
npc_sprite = npc.sprite_index;

if (create_in_current_area) {
	npc_other = area_add_actor_3d(obj_control.current_area, npc.x, npc.y, npc.z, obj_npc_other, properties);
} else {
	npc_other = actor_3d_create(npc.x, npc.y, npc.z, obj_npc_other, properties);
}

npc_other.visible = false;
npc_other.is_transforming = true;
npc_other_sprite = npc_other.sprite_index;