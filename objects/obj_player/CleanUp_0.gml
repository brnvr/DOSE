array_foreach(inventory, function(item) {
	sprite_delete(item.sprite)
})

instance_destroy(cursor_wave)
instance_destroy(raycaster)
time_source_destroy(ts_item_selected_reenable)