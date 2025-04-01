function vfx_step() {
	with (obj_game_control) {
		array_foreach(vfx_filters, function(item) {
			var interpolators = item[1]
	
			struct_foreach(interpolators, function(key, interpolator) {
				interpolator.step()
			})
		})
	
		array_foreach(vfx_resetting_filter_indexes, function(item, i) {
			var index = item[0]
			var on_reset = item[1]
		
			var interpolators = vfx_filters[index][1]
			var ctx = { has_finished_resetting: true }
			struct_foreach(interpolators, method(ctx, function(key, interpolator) {
				if (interpolator.total_time_seconds > 0 && !interpolator.has_completed()) {
					has_finished_resetting = false	
				}
			}))
		
			if (ctx.has_finished_resetting) {
				on_reset()
				array_delete(vfx_filters, index, 1)
				array_delete(vfx_resetting_filter_indexes, i, 1)
			}
		})
	}
}