function afx_step() {
	with (obj_game_control) {
		array_foreach(afx_filters, function(item) {
			var effects = item[1]
		
			struct_foreach(effects, function(key, effect) {
				struct_foreach(effect, function(key, interpolator) {
					interpolator.step()
				})
			})
		})
	
		array_foreach(afx_resetting_filter_indexes, function(item, i) {
			var index = item[0]
			var on_reset = item[1]
		
			var effects = afx_filters[index][1]
		
			var ctx = { has_finished_resetting: true }
		
			struct_foreach(effects, method(ctx, function(effect, interpolators) {
				struct_foreach(interpolators, function(key, interpolator) {
					if (interpolator.total_time_seconds > 0 && !interpolator.has_completed()) {
						has_finished_resetting = false	
					}
				})
			}))
		
			if (ctx.has_finished_resetting) {
				on_reset()
				array_delete(afx_filters, index, 1)
				array_delete(afx_resetting_filter_indexes, i, 1)
			}
		})	
	}
}